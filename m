Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0E3644C5;
	Sun, 11 Oct 2026 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715111; cv=none; b=kmMAjlSZrdy9PJ/wxT+AbU8L8BzewiTa+6pjr459NrXQ3Z4DQm4q8p4Xp92wq02GEY6XVrZilhGjrV8nBbIE6JwaKjHHjrdFoa+Wsr9FXR1mzZ2vWPZ8apyJDwnhW5h9iJhgpEUjnAr90bApwKbxtTdAdamhAmnzoSSWxyIXelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715111; c=relaxed/simple;
	bh=5rJvP+wjDiLPkOY/yBXzdgxxfI5bFNSGOGeRPi1yn0E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pt8/ozV8bfNqE136jkiYpFCMsJAvTI/9qiRoX3j8/vJfxPsKpTjnG1QTQe4J6iXTZrIESgMkLGE4d2t7GGm/Mglnq+Ze3MPtf9NfHUTVUND+7Kub4JPegwopDUVKvIRob4mAXs5yGOE1sXHZxqsEv4FuhPECRuTjrJKt0mIlhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYC2D8Tu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYC2D8Tu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBB41F0089B;
	Sun, 11 Oct 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715110;
	bh=4X2c8KnPvY/fWVDV6z/9cBUZlxLIVOezpXC3qPode2w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=cYC2D8TuYXCDsh9S44XarmjVFNrpEJQ6VdSgMk1ycFevLEQHZQBalgVvkDWAbZIjB
	 9Q6jvzWmPzRS95y1bi9O4vOyWN++RpVTPfA/r4QyorSqtZZqzosMEZNpSs89dhXbcx
	 kMxakjnojm3xbd0urX0mXkz46y8i6Kk7VuIt8N0G5EMHoiM/iB0BsSJ+Iuy+MxsVYe
	 E+L+1p6R2hln7QGcS2AP2b3rNgoGQoOUkTTjOIifLzwjG0erDTzP8UYebLNMCsPtdk
	 1MCAfXJpW9KyzoGTzuov+eY1KON3B235ONifW2smfOLRoqvwB1YcJ8HEyPqpDDI/tv
	 GWNJhHN/no9HA==
Message-ID: <2682e98c-826a-4fc5-8184-bf9b8a20abb7@kernel.org>
Date: Sun, 11 Oct 2026 18:38:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, daehojeong@google.com, joannechien@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: allow empty strings for journaled quota options
To: Hengyu Liang <hengyul@cs.unc.edu>, jaegeuk@kernel.org
References: <20261010165750.509939-1-hengyul@cs.unc.edu>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261010165750.509939-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/26 00:57, Hengyu Liang wrote:
> Commit 2a3db1e02ce0 ("f2fs: allow empty mount string for
> Opt_usr|grp|projjquota") added support for passing usrjquota,
> grpjquota and prjjquota as flags to disable journaled quotas.
> 
> However, it also replaced fsparam_string_empty() with fsparam_string(),
> which rejects an empty string. As of now, mount(2) and
> fsconfig(FSCONFIG_SET_STRING) reject usrjquota=, grpjquota= and
> prjjquota= with EINVAL, although these forms are still documented in
> Documentation/filesystems/f2fs.rst.
> 
> The issue can be reproduced on an F2FS device with:
> 
>      mount -t f2fs -o usrjquota= /dev/loop5 /mnt/f
> 
> Before this commit, the command succeeds. Afterwards, it fails with
> EINVAL and logs "f2fs: Bad value for 'usrjquota'".
> The same failure occurs when remounting to clear a quota file name.
> 
> This patch will restore fsparam_string_empty() for the three options
> while retaining the flag entries, so both forms are accepted.
> 
> Fixes: 2a3db1e02ce0 ("f2fs: allow empty mount string for Opt_usr|grp|projjquota")
> Cc: stable@vger.kernel.org # 7.1+
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
