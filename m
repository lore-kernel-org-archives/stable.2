Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07512868AB;
	Wed,  2 Sep 2026 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329591; cv=none; b=eMcJsFRHSseiYyyO9RGrUQzXoDS/XSwtVRV/hkubMaYcTWre1iubnQ19uqEw5+O3op+xdYXHTKFTF/8rWW6/xRPdPN0obTSomjC3rtrL60hLm+abRNFjv7hhVz5XCLcxTGMEfIUlr8TLk6Vhyt3uKfVu4ioXGw9msaYuJRaXzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329591; c=relaxed/simple;
	bh=NnIANPNQGbdroDQw4v1tOHD/Kw8SzVZIE6CHbITMjS4=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=o1/PShqfXfHQIQCUA10zFf7r0SgWMRvN4nIGwCs52VmfmNxzsV3Et68IxH0qCOASXFmvJvJ+h7awiQTUBkCtV6OgCNZfdZANIOoF2cV+vpiAOL1OlH0iFe60FMVtaVJa1AyDwphXdnOVG23hMlVwivBpg0iz6fT1U8N3vA6BGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=YQYCb4tY; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="YQYCb4tY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=ESV5D09ZSJvDJBytxBulfATFOx0Z5MmtTMqiLjuVkug=;
	b=YQYCb4tYnMdrP5lWU8AkYbjeYdvolPdAUDCNwsrL/7SdR7wcA28IXenHhKwxIL
	+OcXoEQoo1GhDXlMRC7K8ZYWhQdAvAKIpSIiyC9Ks5L+idUcy3MsmBan6fUWsZzD
	9B8y4J6bMxq1OkraLoJ77nU/eCCI7Opl8Q2Uv8YMY4474=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3t1hWvpdq7CsiAA--.27068S2;
	Wed, 02 Sep 2026 14:12:39 +0800 (CST)
Message-ID: <6A97BE39.8090301@126.com>
Date: Wed, 02 Sep 2026 14:12:09 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Namjae Jeon <linkinjeon@kernel.org>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: hyc.lee@gmail.com, ntfs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix lost volume flag updates in set/clear helpers
References: <20260901024551.528056-1-zenghongling@kylinos.cn> <CAKYAXd8dotRFBu18HOZGr6AJn4EfTwj=ZtfwheCTy0H7tbLfFA@mail.gmail.com>
In-Reply-To: <CAKYAXd8dotRFBu18HOZGr6AJn4EfTwj=ZtfwheCTy0H7tbLfFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3t1hWvpdq7CsiAA--.27068S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw15WryktryftrWrKrWxWFg_yoW8Cw43pr
	s3trn7KayqyFy7WwsFvayIyryFga4xJr4YkrW5Gw40yw1Ykr10qFyxtw1fuayqyr9xJw47
	JFWjy3yru348ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI0PfUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrhdFFmqXvlcS2wAA33


在 2026年09月02日 09:06, Namjae Jeon 写道:
> On Tue, Sep 1, 2026 at 11:46 AM Hongling Zeng <zenghongling@kylinos.cn> wrote:
>> ntfs_set_volume_flags() and ntfs_clear_volume_flags() both read
>> vol->vol_flags outside any lock to compute the new value before handing
>> it to ntfs_write_volume_flags(), which only takes ni->mrec_lock around
>> the actual write. The read-modify-write is therefore not atomic, and two
>> concurrent callers can lose an update: ntfs_sync_fs() may derive a
>> "clean" value from vol->vol_flags while a writer concurrently records an
>> error and sets VOLUME_IS_DIRTY; the locked write then silently
>> overwrites the freshly-set dirty bit. The on-disk volume looks clean
>> despite the recorded errors, so chkdsk will not run on the next mount
>> and corrupted metadata can persist.
> This patch description explicitly identifies ntfs_sync_fs() as the
> problematic caller, but there still remains a racy issue after
> applying this patch.
>
> static int ntfs_sync_fs(struct super_block *sb, int wait)
> {
> ...
>          if (!NVolErrors(vol) &&
>              ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
>                  ntfs_warning(sb, "Failed to clear dirty bit in volume
> information flags.  Run chkdsk.");
>                  err = -EIO;
>          }
>
> Sync thread                         Writer thread
> -----------                                -------------
> 1. NVolErrors() == false
>                                               2. Set VOLUME_IS_DIRTY
> under mrec_lock
>                                               3. NVolSetErrors()
> 4. ntfs_clear_volume_flags()
>
> The volume can be left marked clean on disk despite the recorded
> error... Can you update this patch to fix this issue as well?
|You're right. My current patch fixes the lost update in the set/clear
helpers, but ntfs_sync_fs() still has a TOCTOU race between NVolErrors()
and clearing VOLUME_IS_DIRTY.

I'll update the patch to make the error check and dirty-bit clear happen
under the same mrec_lock, so the sync path won't clear the bit after a
concurrent error update.

Thanks |

