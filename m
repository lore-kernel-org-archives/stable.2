Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBC395AC6;
	Tue,  8 Sep 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852123; cv=none; b=iSrXM8ZTOEdHaYKLR3qFDDsZI1xI7RIajacFwQoRDSjFGyi0GFVjdYg/wMuvqi5siQUmK4SKRa4LunZ6sBlGlKOW6EpmDgzAJvk62F4sh7+0L82haW9YkyA+u2oYVB6ZYOq0rG5Xk0V+hzOB5MASEODBJEN/RONcNlRvkev1KF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852123; c=relaxed/simple;
	bh=yk3fex8l90OWAJYTeqEGFpT9btixLVx91j8gQTCXlSY=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=dQBHthTfZeOvcolhJ0dEHw5Hcwpn0VEGy/yibmAI1nV/N4A5NPPVUB5cZ6fsEwmX1UWmx5lpPWBekp6uwah0lZwNQ1ItSHXtuORpTvvAhlpwAHO27tO9kvL1vH0DuAc+J5jGpPmMrvNmy4IgCoYnEMXSp/BFyleO0QX3TOTFdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Y+7Tp6ui; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Y+7Tp6ui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=UkOwMntL7PWD2GuegVBQRCB+yMtgYRenC1HnEsW7qtI=;
	b=Y+7Tp6uiMMU1D2K1MsJnujLm6dPSwUqo4hnIM8nZvAKc0fVwaMTFJ17mixhwLU
	w/h58FYfczCfLNDBa0W8ZHAvi6R/lhtZhKHYnGdGvm/AtadTHadv+4ffjcydzsS2
	wtCyYWXSdPWQFV2yXToTWteyzD3EeoIHviG69/wfqafL8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgC314Fyt59qx_ufGQ--.9752S2;
	Tue, 08 Sep 2026 15:21:22 +0800 (CST)
Message-ID: <6A9FB756.1010302@126.com>
Date: Tue, 08 Sep 2026 15:20:54 +0800
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
Subject: Re: [PATCH v3 2/3] ntfs: sync the volume dirty bit with the recorded
 error state
References: <20260907070852.291323-1-zenghongling@kylinos.cn> <20260907070852.291323-3-zenghongling@kylinos.cn> <CAKYAXd9Hs1aEe_Tx4QwaKVUWM9RSrkAcO9Q7naMQWxg_2G0vAg@mail.gmail.com>
In-Reply-To: <CAKYAXd9Hs1aEe_Tx4QwaKVUWM9RSrkAcO9Q7naMQWxg_2G0vAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgC314Fyt59qx_ufGQ--.9752S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15Zw1ftFWktw4DtFy7ZFb_yoW8Wr1Dpa
	yDKwsrKFs7tw1Iva4xAFW3Jrnavr92ka17Ar9xtwsxXr90gr1FqFySg34YgFWIkryFyan7
	ZFWjyF95uw47AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI1v3UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoROMXWqft3OrggAA37


在 2026年09月08日 12:10, Namjae Jeon 写道:
>> @@ -1621,6 +1666,11 @@ static bool load_system_files(struct ntfs_volume *vol)
>>                          ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>>                  }
>>                  NVolSetErrors(vol);
>> +               /*
>> +                * Remember it for the lifetime of the mount: see
>> +                * ntfs_sync_volume_dirty_state().
>> +                */
>> +               NVolSetHibernated(vol);
> Could you explain why NVolSetHibernated(vol) is called for non-zero
> return from check_windows_hibernation_status() ?
Hi:
   A non-zero return does not only mean "definitely hibernated": > 0
   means hibernation was established or assumed (the documented
   "treated as if Windows is suspended" default), while < 0 means the
   check itself failed, so hibernation could not be ruled out.

   NV_Hibernated is a conservative write gate, not a positive claim: it
   keeps ntfs_sync_volume_dirty_state() from writing the $Volume record
   on this mount. It has to cover the whole branch because this series
   changes what NVolErrors() means for writes: it used to suppress the
   flags write, and now the on-disk dirty bit is derived from it on
   read-write mounts. Without the separate gate, an rw mount of a
   hibernated volume (errors=continue) would gain a filesystem-internal
   $Volume write on the first sync_fs() or at unmount - exactly what
   the hibernation check exists to prevent.

   err < 0 is included for the same reason, only more so: when the
   check cannot complete, we cannot prove the volume is safe to write.
   Gating wrongly costs an untouched dirty bit; not gating wrongly
   costs Windows resuming on a modified image.

Thanks!

