Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A93E5A19
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983575; cv=pass; b=h+/Ngwj0L8wa8ttjULeh+LS1pfKfAZGS+FDLnf/yDob+op839y7Tfk9j593pGN5Rnr/tdUhmwGR9NtHwJVQK6V5XsMEQt1Ie0KpNbmcChRD5+6JEQO7nEHH93oAJFF5E4kYlVAUd8s/fMIFCog/mPbmj0w8Eu5vYyIL8+E3h3a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983575; c=relaxed/simple;
	bh=ok9b/hGgMHy0RvQBlUb/jv2F/avpSyhfO7YHzTf9RfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjCzEx47kyG5AgXoGJmfnH2nrFg4XZ6B8ABEl7Tqz53DdNik0nH4x/eeorAHiOtzHkJc9X/TJz/zxivaorusC1bWK8jxrNKzDu0ZeogUpijGs23omWk+VTypX7CX8aB2Vo0RaBK5VXVKwI2VUwaVO+OiZGv6lGFXdxZu7isIj0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPf5m405; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPf5m405"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb34c17b96so2652227a34.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 09:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786983570; cv=none;
        d=google.com; s=arc-20260327;
        b=HCutjxgS/lXYI9U8W1rq3LwzNaBOtOtKNh1xth6HJ0iMg9x4Yva0SY7nHUEH/3Abm3
         vc7UweWvw2g7IFgTphFYxNyl3gsm5y3Wrl0wjrqaAJz1GpjoRUdNAdWUBITgwZGjO9WH
         jok+eyOnl6dSh9fSz1LXTbSPfFPKx/pD0HbLDOnXIqVYmRD2CpC8WrmdsvZlNCQfVagR
         E13LuQH13zDzUoVR+JEAVZ32wfOD1H6oMwYFDp/wrMqWBrbJpQBuhBv3HAoKeYLTyxin
         j8O9OcQe0UzPVr0UcXs6svKkeVFvquuyadiotOgGsuFi0It2z5zlWSY7ur9ZimV02x2x
         4NjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ok9b/hGgMHy0RvQBlUb/jv2F/avpSyhfO7YHzTf9RfE=;
        fh=jj+Vv3fAXarIBR92JKLXLuED41wZt2hPa4l+wXi0c9Y=;
        b=SSWSRnlflbzWMWsvXH9S72zFMBsy4hfYQuDY1/+943OsI2sqziX5kC7k3+SSYT3hBu
         +2+e8hBa0m/1xZkORtNDSdLp247TUpJIbPn6YZdSyH9iqonRUpOyQgCvUsqZ2NRdRvsJ
         WOVetwaX41ygE8mHWOre1qM3DnakNPlcyj3kf/83bD+fBRdzMo3r9rwQXuf7vEG9paPo
         xQxzftMARhSu9bCmArDoh1swVN2CxoQXdyUKILzAS2P6UhLQyhOmBy3Q3lDUgkxM8vyu
         De2PwXQCiCRLdd6JJvMEe3SYyWu/ul7kmvWSWjQISeE25Ci8NZxuNX99x4DdxfTMcuZM
         jZ+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786983570; x=1787588370; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ok9b/hGgMHy0RvQBlUb/jv2F/avpSyhfO7YHzTf9RfE=;
        b=JPf5m405qPvZwR2e3ujJvHhR2vqCU4opbuw1B7H7DhzYIgSjZs7yC4TP7s2Ujm/K8K
         rEKXzV5fo5Zw/goVj7ZrJKiumFXdTZPszwF+GdgNTX4SdjPHpHS6nz1J/MDUCZU1g10e
         svl0D1KT36pKyfakNXY/lfCRXxow5cIJwCSE6xPxFa9Wjdw27hLNxJCFGtK/lo6GsDEP
         PXR7hdMQbNudyzzPV1K0jOB4flHjNDZ+PXOi1cEZ6dtkvXZD2WEeL4QegMZnqg6cu+5Q
         kjGhwlN5/FoFWxvkBLw3KuuNsDahkMldxyQJt6gb2/3u/yC3B+gYq1gaTh9sP7934scg
         yBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983570; x=1787588370;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ok9b/hGgMHy0RvQBlUb/jv2F/avpSyhfO7YHzTf9RfE=;
        b=lAAi1xrStD6eTp7uquZTI4O9+kOqrKx/J+l26rOdL8h+Pi1LP5SCjp2lpJ/at4lJJR
         H20hilsACY/6u3S6AgQUhedcfNqXDBXODK3JD/nQGIDUB5Wpmn8TpmD5H0ZoAWb/hmMw
         +eTQoj/t3ehHGEoiu9uBKWY+Hh14iSB+XFfEE0VTsnVWa5ue1J57Xpjo18UvBDztJdwV
         jrCp/iQCwlWR4n453MvmO91BCgKgr/AE4j3QLKcuNicWa80iH625Fq3PDG4Ocu4GfFK9
         rJ/ohSe0HqSjmfsfsJFGofsL8SYmzG7ts5QC0GguN5OLTwzGYQjzVKtGO0lKHUbmhhDk
         /cyg==
X-Forwarded-Encrypted: i=1; AHgh+Rr92dpbOyq61lQKBsZly7ymwwiqlrOCbpzjB4SPDlMzWVNg1PbyOyso3gVEv8+5p62na2UUex4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkU9TlDs5459RtZErxotljuq/8P77Xo4NaZTJshMoigQyie2Na
	vEZ+g9V2siqbVRNXey6TGh4UzCEzFrBwe7OdSMtCyMKXde6KWvsq68w5JyRfMgDTmwtH7MkGHJF
	CsPGOvLpUev5cfOjU9WAQ2Z8SLQtm9Z8=
X-Gm-Gg: AR+sD12Kt/6rqnUOqZ87bjnoVuCiHfY6+IJUVATzUZEvJuz7xv76BE/plomc+gMJwOO
	2CiKCjIuJ7Zh6qmUPVUW4kfNpvEMusrSbp3MaW3nN6QTRkZcsNDrjn9U46PvOwnHDxEATlfBnbY
	jUCyLFizqoxeBhFqrYojTp9rzOg584oJZMtKdAvBcofFbU3sJ4bFb8ycEqgydROjpA5SFduod2/
	2/QR2kAc0NIk6FjB9FKyq/hwpJxPU4/wEdy15gNcj5w3TeZwyRjM/Bu7ufl+2ZvVkDv8rzkJ62L
	W1TP02hnq5akGtCF+thQHdmeoXNzi6atSdiL9vYsd1jLwQaYABvOHLDDe77DmAss2K9tf9LnVhE
	=
X-Received: by 2002:a05:6830:2708:b0:7e9:cad9:4bc4 with SMTP id
 46e09a7af769-7f3de64c4e5mr26475112a34.7.1786983570237; Mon, 17 Aug 2026
 09:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815193839.141406-1-devnexen@gmail.com> <aoLZ5e0ffVvZ-FfB@zed>
 <CA+XhMqxR+m7Jt0UUHetCfXSHHtW5w-jUc0_PSSWjTbprYn8ZwQ@mail.gmail.com> <aoMuMvE0zJG1MYD2@zed>
In-Reply-To: <aoMuMvE0zJG1MYD2@zed>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 17 Aug 2026 17:19:18 +0100
X-Gm-Features: AcwNN1WZtk7Zm16KusB7eA5zYDAAIyL9cuvp343NEcRNeo5rJN7TigkzkaaAfMw
Message-ID: <CA+XhMqxY3u5YR06j8jX2+wCwX95vQrb5EVH39GvuJXrwA48XWw@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-isp: reject zero-sized parameter blocks
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Riesch <michael.riesch@collabora.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 17, 2026 at 05:56:30PM +0200, Jacopo Mondi wrote:
> Should we instead deman that all entries provided by the driver are
> populated by failing validation if info->size == 0 ?

Good idea, and I'd rather keep both in v2 if you don't mind - they
guard different things.

info->size == 0 is about the driver table, and it lets us answer
"this driver doesn't handle that type" rather than carrying on with
an empty entry and a NULL block_validate.

block->size < sizeof(*block) is about the buffer coming from
userspace: a block's size includes its header, so anything smaller is
malformed no matter what the table says, and it keeps the loop moving
without depending on the table at all.

Both are a couple of lines, so dropping either one is no trouble if
you prefer.

> Right.. you might have seen ?
> https://patchwork.linuxtv.org/project/linux-media/list/?series=29170

I hadn't, thanks. That takes care of the rppx1 side, so there's
nothing left for me to send there and I'll stick to the core change.

I'll reword the commit message so it doesn't lean on rppx1, and keep
Cc: stable unless you disagree.

Cheers.
