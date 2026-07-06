Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E53D891A
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368677; cv=pass; b=DjUpKDogonKMpYaWOWAiNpHmh8RpWZLVn/93cagsZnaZg8MXtsRrKH4MgNQKQz2GdbCq9BGMrBX8cSAM5vH/ZZABXvJhMNqYJoZt9YMN9vkePD/3bSQAAjkpgpZgmnP5RSsQ5EXvP13mgGvr4C4L8NSGtTp49U8fTvDlafT02OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368677; c=relaxed/simple;
	bh=yMPcGqETb1sVOfA2EfkLEzhu+Qw3toGJG9+DCNHbzTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulESfKeG4jBRiPMNp2T3tAg44hUqNFvrdzy641CeEWWhvJF1lFEIs+37XziYgGm4KLZWffpSNM6qDK0oAR29N97QQQ0K4c9bW/favElzCdDgSFU9m+H7nLefqRZ9ccbS76zpbs693GI6uPdiWmpXt5uF6z0+pcUC5SzZGIg1Jqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLO/6Y6P; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLO/6Y6P"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7ff05e5d009so39574427b3.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368675; cv=none;
        d=google.com; s=arc-20260327;
        b=psMShtPCN5ZydkGTwnp3+E3ysfa34YI0F+gkLil8Dp0LgcUD9Yed5xir78J+cGuiGk
         sX8Cg04ZrHXFvtl85+Lgus5ogJkzfRKntzMaAdoRNU/srcpEsb+BegGDpWcX8oWA5ktE
         UKkR3WdUWTVnjRDHwKlYqAgUqj7HRydDRywckMvvY4Jwj+hjAt+41LTmtjAf+I+sxkwZ
         IJ9cGpjcQaOUxq16gZ/okRMdRiW6yQKvFYsAlrTr1ZgwFSyBoNDkJcZWnysy/ToSZFrt
         KKtJZJrgJCORGbee9RpqjS25CTJWXbBMk+XuIhuXnlzXtUJpeYWDvfY0E5H5FkSHJ+58
         EGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zm66ESlbCDanOzCJkkaX9q4klvH1ip3CQSOWs/Z24c=;
        fh=XcR82XLKcN2L40AuhO0nl0+cGH2sShXbJLIsjafSk04=;
        b=W7xZyMlcM+nKHt11C7cl7bqthIAuqUq49+aCdderKEho2EGmtBvw1IXaiuBRQlcH2/
         RRqwyP29AjxL/fvpMKZzv12zRJILSB9pHNPA37BZJInpfj/UtbTey1xVMoeLSUR7pmaE
         m1YUDb2DnAdzWKrwZb8SsJlYnD1bPs5l3eGd+evtuBvIzM7wqyMJUHWs3cQfagvHtgZs
         7xDKPno/h+R+cxPcS7RVXwfyI4n6rV2KWDe1MUEVPyhV5/3ndiXSAFDUjzDfFrS5EUsf
         /75zU3SjPCtg187oHCMkDh7lxN1+b2TWAPXqW0+3m0qQ5iHv7CtJoSfMZmFKHnnPX3SD
         cr0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783368675; x=1783973475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zm66ESlbCDanOzCJkkaX9q4klvH1ip3CQSOWs/Z24c=;
        b=fLO/6Y6PFNC6Xdy3DZdXfK8tE44uj9zm0TwmQv9rJUKkokvrQNtj85o9l4aqjtFXPh
         BNnYipZ6bEprgNfcCE8o3FQnmzU1NxuNCdQltwN7mXdMfk4tWVVphaTOvDWvmS0THEln
         5ccX6seH3gbkpNk20POVO8G0Ym6XRVI3HU5UZeYN/mzDJNbMBKAoYU5OAm9z01obr/fg
         BcMNSsaMiGQ84G12TQyS4nMX/pCePY/QA60KTzkjCeFpkff5kFWL9gZ1D8tivFvYyKzD
         hs7HsJTf6hO37Lja0r1WOkJvKgJnJlEKA2rEC6Tpy+4gsIXl8IYYClb93UPcdikBi4Cr
         HWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368675; x=1783973475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3zm66ESlbCDanOzCJkkaX9q4klvH1ip3CQSOWs/Z24c=;
        b=k5Bt89AIeBCamXcrTkUmuOGW4PjV9dJfkI3foqlK6pVO0De5Y3So2uoqWPvphRo0LX
         2533V7uJSorCscYdbPAHDFQ8dHJSPIT+dfxNjF0dSTcyuQWJvZnqKgcjwf+S0Zk5WIVI
         z/1DEWhMaLXJ/3e5eKyqwrFEXO47+1mRJQrCgk9g7chLjuvO1YPPbmAdV5MMtQE2024/
         gkVwNk47JPCUw9X2sPm6UPCqJ6hxzEAYWDCCedWC8JxUrW+GxLP8/VEIWWWSMUDiuaQa
         8289xo0CwtgPC6bBL/+jtc59+RdCfR9+ziKYcNrrKaDWAvPYorp/IQ9lEuS7UUuU8HuS
         Nwag==
X-Forwarded-Encrypted: i=1; AHgh+Roqs3o0EImenkeWHoxL5FLfUAtC0Y3Ma2St2mqcYzMD4ODhYRWPvcnviWIXlVyTywkoUP2elL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkIbclx70dUCwZ6qt3Xb0EHpmPqvduyR2qxIvwh8RBtVPYzwj
	Y/kvcb/8f7vLlPV6RDO+Mjct1NWWcodDNbACqfiTITubC7lpZ5BxDjcCjVQpk7xRr4jxwfNfmew
	Ka5Hb/wHF7mNCFFLyAf1F7x2YZFLp1jU=
X-Gm-Gg: AfdE7cmftMly3ccqXPIVF4VrRbSFghAfEz7awrsrCtJ8WpQa0wkebHu1lj9Q2nArvZl
	OPfRpLP3CCo+K8oEgQXtoYlRSUlTkcqG5Cn2DuPqNllID02PtIZZh+FFVj8CCdX6hIalcp7TaKs
	YZRR80aFCbeF2QpDe2x7nsk8je15wNT5rJRxrV+jvDOlSYi4T8VVDMnk4r9tJBEuy2hC+Y1Vboy
	tyF3ITp4oXHA1FZXjyjavTDJEYv7ONSqTOSOHBux1oSEiPsH57N/KbSpSKqR6iWjuZFIj5aNLfr
	Y82oKXDG/+d7ieRFoFcyFsGqFQ==
X-Received: by 2002:a05:690c:4884:b0:80e:16fc:5bc with SMTP id
 00721157ae682-81be276ec1bmr15125827b3.35.1783368674678; Mon, 06 Jul 2026
 13:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
 <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com> <20260624200535.GA132-beaub@linux.microsoft.com>
 <20260706160650.2791767d@gandalf.local.home>
In-Reply-To: <20260706160650.2791767d@gandalf.local.home>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 6 Jul 2026 16:11:03 -0400
X-Gm-Features: AVVi8CfITkA8qNrd0NsvAlpPNxypVSy_SkHP0qNijMyk9oK0DmBZjrSsOeUSyug
Message-ID: <CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in user_event_mm_dup()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:06=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> I'm taking in the OP patch, but this looks like a separate issue.
>
> Any update on this?

Sorry, had gone fishing.  I'll have v2 in the next day or so

Thanks,
Mike
