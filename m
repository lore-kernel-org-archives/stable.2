Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230924A05D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311769; cv=pass; b=bYPDxnULZsnyXv2WXL4hD83enp8l6usx+j9IyO6An/RKS+AdvGZj4iwZRD8HqEROnKVvBzkMMPiUMIYpyxXY8ey/gXh0X+2qqnw6BMxlaJn+8OUArbVCTdlzdw+jCbB3Z0OMiFw7+aSajaoiyUahT2/h7QCgFbAcPfmB0mILdsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311769; c=relaxed/simple;
	bh=IXG2KCbImGkse2jGXDiJcldsNv7M/iRFg6PL2xysy7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT+hDAsSGd6DeyZ50GX1ys2tmqNeQMU9TFG87Mp/gmwhMfCXhzWO61xT7emkbj2qctRo0dOGpdAMMgblbA/dHotVs6ZgRpC0Z50NdmuiBIdHaDZgKaUuXINRT9Y/yKpcMq6Ic9JSht4lk9McGWDCBcwZXRdlyROn3Jlht91zL7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnrGZOZl; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnrGZOZl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so504029f8f.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788311766; cv=none;
        d=google.com; s=arc-20260327;
        b=NiaSAU9MXOWRl17eTAeVOs94weQLBdP4oDf73DZgBCO2s+Ac5Wz4YZ1EpCaOTDhOn4
         THpGVUFj5utZpZAVWMAIJUOpf/XSemNBB7/1jDWZeBQuuSOd6hJIzZsmelxfWMVoZVbO
         Vn8IKPgfLEjbH4sJuxTDp8d5LL5mJk5zqlBBS6GqC5V4SWY2jIs0V4mVfrGa7Wa3wHkA
         aQEPg2A8ekvpbbqYsqkAJxckB8OTwZ8Nra+7VmNr16ijPykZewAXqZRWjaum1e8Y1AKf
         8KsDU/2qFzw5cSLmCr4djj0qIhhf2wFxV9VABW9Zx4Wc047sNcZorC2/ogD5zkMVHE+S
         V+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IXG2KCbImGkse2jGXDiJcldsNv7M/iRFg6PL2xysy7A=;
        fh=O5mjre4lCcORr/Klr5RKjlpFY+dtNV6Ny70L7sZzjmc=;
        b=IKqTISDC7gvHgZwIt138uVClA5lbDkWdKvhdNunwCNIQNyDLMKetWnayJHt1X8Kjl3
         Hy2a1gQB69L4he8OKB0n5/oJkK3dITZxW6/oB8cN97a3zLxWzDSAF0ROVUEqPcl3+Pxb
         /i1NznGo+bfiNVVmpVGxHxgpDffbiD6TYLnhE7Y1ZGL4WBSNvgAboOyIzpra9DUgUquZ
         EzXhtCQk5c3BchQgqNC9wCZcz+xeX0E0N6Aou++TWqsdf3N2YUGf/OqrY56KCb2oNnda
         HypWJ6S6226hf200JVCp5J5cu4O151GBF86vTh3TDvInXhRvRqF6wDtbwf1Bck8J1WWL
         4egQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788311766; x=1788916566; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXG2KCbImGkse2jGXDiJcldsNv7M/iRFg6PL2xysy7A=;
        b=rnrGZOZlMAX3UmCRrMXFDe7L0FvALvb3cv5AHDo0U0oMjHA4kifRq5ZLHdy5p6SU20
         Pzw/cLBU/twEHZaMAdGA0ML1UoOzzF+BRs6uWTsYGpgmIhToWmbSqfzafzAxBwO3wYoM
         foNp2CHlznQQP7sogjtPIxOWcx6gyDZU2KECgwEZ1ic5AqSDBP6SNhjSzCYtAb8XZbzL
         FQ/UCewamFvUm1YOUs4vVdPGd3eu/o5KGKv5Gz53jL40VALtNA72ssVD/aJj2tQBNf+y
         prHs28toqnagGatteSofwUWUP3AK5CRLg6LdrDzeccpOdsFWmqoXYwEvaJqxYMfUuo2j
         TJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788311766; x=1788916566;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IXG2KCbImGkse2jGXDiJcldsNv7M/iRFg6PL2xysy7A=;
        b=qa7WAZqMYS8/APhYppp1y5zSvm26wEaPUiqV8kNGtrRGC10GNIyCs9+FHfRm+1Tpfd
         2c3qS7+E/p143qZDcSQ1mHczguHUGFwoA9b5Y0rPXpwoyuxgGe5Gwpr3JjXlD8zh7roE
         GZIMqoPAXOfk7OznBKtSzXFB/A7mw8OGxJBH3wsOCQX3cavLI2NKFAEBvlt+ugZGLX4m
         IS6P69zJIc+/e5IfI9SlT1vR4ylM4P9Zpgj8GrBrJmx4N5GfnzmgKrwtxDHwSSzBafsH
         fVPY4cKcsDotpUf96vZO6UPmsPIBlkWQKn68pkJpe7+thsXigrRfTuzOYvpW7Sy9YrZx
         F8fA==
X-Forwarded-Encrypted: i=1; AKwUvBxj1o6UL4j01yQzG1BLryVoVMQ1FkQWJwc1ZJJBqO/KpeL8+KOIMXqtq54HBHfhe0kCCKOx0qY=@vger.kernel.org
X-Gm-Message-State: AFuF++nVbIzoMgw+7z2RDh+ECwi31psQa7ULxFZHtXjwutz6qi5wvuNW
	SH9E6RCjMv/at3fWjEKBATC80bC/f7jwt8qrOHCP0ciy9r/sS2B15MXXC5D0xlN8if63Maj4kaL
	//aquhlTYo2yWTrbIIKzxK8kGsVm6ORxS8YSUXHHN
X-Gm-Gg: AYBFou2+sHQtgNzHShQOrwlQU6tGe9ieqVNYIWcRhfyluqofPI48iSfl7EZjzVi1yLC
	yAkUGKU5qzd5w+brYGzzRVwHw97EFaveG7ykb9EgMimHsVlRAQ+s866BQkW5K8Y+7dFhXnzYtkr
	7xSP1HbH5dUzk7HUgAFanDNPJP+gBa8vsDVX35sJUYWj9gWPqa4uJagK9pDCdcd4O89GfeJSJDT
	KjmcTnWXMdVSdDpTbiUCEtkcvkD6uQJxvkIXWIWDGaOgJTkwLdFH2e+bTWUb5Biry24oMIGL5Y8
	NhRk5LKEwMqJ21pzq756dDK0sS9Dszy/+urwKJAotO+U0AOWfTo76mMwIKCG7XZ3zzs9xCpQ8mk
	=
X-Received: by 2002:a05:6000:610:b0:47f:34ba:2d0d with SMTP id
 ffacd0b85a97d-48488dfaf77mr1818183f8f.8.1788311765710; Tue, 01 Sep 2026
 18:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825234545.2076049-1-jthies@google.com> <apVZVCzUEXp1Ahv2@black.igk.intel.com>
 <CAMMMRMdiAF1Kx9CAwZrWCiLGjrzVnoQ_Rm-m-UXSAF+fhS+y2A@mail.gmail.com>
In-Reply-To: <CAMMMRMdiAF1Kx9CAwZrWCiLGjrzVnoQ_Rm-m-UXSAF+fhS+y2A@mail.gmail.com>
From: Jameson Thies <jthies@google.com>
Date: Tue, 1 Sep 2026 18:15:53 -0700
X-Gm-Features: AcwNN1WTrRxd9fhimNdvz27qwM-VziUTihyxqgKl_8a-VrgZw7w8_yKF8fKHbqE
Message-ID: <CAMFSARfWY6k=_5Yw0S6uaPs5XzVyAJA02EuEELwu9VQEKw+2wQ@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: ucsi: displayport: Fix OOB altmode array index
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bleung@chromium.org, gregkh@linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki and Andrei,
thanks for taking a look. I'll follow up with a v2 of this patch to
address your comments. Answers below with some additional comments.

> > Can you remove the above line while at it?

Will remove in v2.

> > Shouldn't that be the other way around?

I'm not sure I understand. Because UCSI_MAX_ALTMODES is set to 30 in
ucsi.h, verifying 'cur' is less than UCSI_MAX_ALTMODES will still
evaluate to false if 'cur' is 0xff. This update maintains the existing
functionality and prevents the driver from using an out of bounds
index.

> Looks fine, but shouldn't we return an error if an invalid value is
> received, similar to the Thunderbolt implementation?

Sounds good to me, but I think we should split up the
UCSI_MAX_ALTMODES check and the port_altmode check. Returning EBUSY
doesn't seem like an appropriate error code if the PPM returns an out
of range option. I think we should return EINVAL here.
