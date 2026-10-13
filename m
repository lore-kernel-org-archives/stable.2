Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622739DBF4
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923496; cv=pass; b=HNOJWfrzzeIWmXld3cBYwVHIVfQIj5I3s4pLt2JNBbJ0Fl2CQzumgrt271zXJMolEQMtg0pDIX1H/4Ptoqjphoysn5n249228dTJpXU30q8c9K+Sv73kXGcfdp748233Dc1VOoQPf5L3+/oAMYmxnN8tL4rg0ZwjmuCS/vIyCyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923496; c=relaxed/simple;
	bh=P1U2KJcqn+7HTIBgCJXu1/5Q+Ev60OJUfqLEphUdszw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON8GW+2sqXJDKBo6AFckIUg95FVqdWhzYFcEdu+yhxSaFSKsu9KovJINGwYRHU5CndLdHQKqBeui00vTYyN+NpDqo3IrNCUq32soRknzo+KrGLpJEcAqqXHqROy7KFi4DBr2OSToAwDryd1Z07bo/gMXYiwg7NX4gTmfJq0RSQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG6QR1y/; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG6QR1y/"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6df5e315bd1so2326076eaf.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791923494; cv=none;
        d=google.com; s=arc-20260327;
        b=h/GB2MJx1Iu+S8bNOHm7Slo8vr8aVwYv2mAfgfO/lQBFrRgowHOWzV5I8VLXXMoEOw
         2xGCaRTPTk/LpJUxuxA0srxK7ij+RLT1w9tZFTkXUc8Ae/+vKLqENSuyKB00HYeurPdb
         b1JVf92d5j906qdMbg8Y/BP2GFohY1l1hoi5OssVU5Wa8ly4BGCIpc5kiME8M5QrbAG9
         jpZ/BFnVK8UwbGoV8nqATUkQKkUDyFFz+8AawWEVbZogAkh/CgeH4gYz8D+9JgL/XJQP
         Ur3EakLvuyDjHR0ZYl8r6v7/upmIIidXEasAPONReXw8hteSAHg5PQMeYUETgRI+lmcE
         ZLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=P1U2KJcqn+7HTIBgCJXu1/5Q+Ev60OJUfqLEphUdszw=;
        fh=3UqDzzfiix2WCZ3GvU8hvNsCd1JlHo0rNsRzJpwxEjE=;
        b=mrEemorwFsKEy4W2gFof2obYqIaIGVDiYZiQfBwmMm/NtOlfDxCnvMXVRBW3Mcs6Ax
         JBctorzpF4G2R4NoCdOYXe+a8RArVjf/FBAVvJX6RP0mW7YtJHr9Ol9kSj9jPOQPx8QW
         nlv/MyXLWD2eaxIT2dFSmGCDeBDkfzypUZ1AmhfkmkE3YOLjyC2sfVSnFmZOjQI+MX6q
         4E6RZcxKevHtPxnPmRVN+Mo/kNT5qj9j7SykcN4zQI1NARXECylrqmguvEVQVjIvX+2C
         h4Q0Q5AVgHeN904aAgejGMe3WLtgOgi+/P6oNEQrcUhq3ChRr1u/NnKVEG4tPjSFBJcM
         Lo2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923494; x=1792528294; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1U2KJcqn+7HTIBgCJXu1/5Q+Ev60OJUfqLEphUdszw=;
        b=YG6QR1y/XKAfrLQ4/T9vTs19LcGRORCy1/+DUXw4ZPzcQ53q8cpQ3SbjffIIdu5BY5
         gVk9Cpo4QHwOcc15oOvS+TG5WcJ9upIPzgwyNCrhlbDePvojUcBO43+Nc3xPXSDHJC0Y
         jg35IKXtJW0uLz41imRw8NKkA268/WEmLSuXLH9UiJTS5uPQ6v31IfeRo+7HZq/m1h5D
         SWgEQtUNz2pl2HqUeUFDjhUKCwKDdh3jiLDIEF7EKgH7fFtJMhzNYIOUTKpbNy9j9jHL
         zuCzaEBZ3jXi2unuhWn67nCqyD6UNudqF2rxZieCH6suOoZ9UcYRCbhBN0ypoTBPV37H
         EjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923494; x=1792528294;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P1U2KJcqn+7HTIBgCJXu1/5Q+Ev60OJUfqLEphUdszw=;
        b=JnsZAHo2iSAFRkubL6gyxdbJmXBojMHCSY+eZ3JqXI6YfKKSys2AG1JPp5WJB2MpDn
         gLlDcMdel1sfSXhrkBcHiR3qokplZjmgccEWAxIRix4pBdfJSA6xsBq4XEXNcudbLcRv
         nBvAkBizNKpdXRV+Ye66np0CGD6WIRQszuRxF7fFBBTaMJ7M546kzS4F7ozEp63TG07I
         pny8zvX/tClQQCVXAyJgnbuBhkXHJeMtfc4cqY4asTM9XDzpSvRtXMg7RXqCmmledRnO
         IlCOQhEqnN6fab0RL4DOYNCyW5sM+hRLt7A/U/TZr6a+Y2SfIs6MTVP9xZ9XSFm4Bp43
         BSmQ==
X-Gm-Message-State: AFq9FYIZ58LSSSkJOZb9y5N6TNJZIIVlyDkcT3sXiY6v3N4RY+CqkN1z
	IM47P5fIfedztVRHYFCbPuy6iJ6VocxF5p/saIEzh5XBVsG94FUkXnWzMzYdMAexYhPfRailySN
	nF8qD1RPoQjS5MO+bV2BAfAf7SnOsW98xHiovAhGjIdtXD1g=
X-Gm-Gg: AYBFou3rmB8SU0f4pqJ4V6IBcrQICRccebmUwTJBkdtvivvvNl/Wc4EpwoAM1ijFtYw
	9E+prhUm+W0eoWC19Sv24CUC9TjeV4CgyJ5P69s4xp7hcDou2VAmzk0wNFEylS2EVQNU8jOjJJU
	3aeFFf/i8kWJZgatBY1W0Ea+JJHeinqGsLV/V5IOYev+9n9rG+MEgI4P+0bzWOAtG56wWoE8lZU
	OLx179mpGKuINyh9yj9EeJ2DCk+Sa25sNlZDq9KKQ5XcV8djANMexI3rmhdyWqarFeQ5wuPL+b4
	9IwdeYSqs+0Tns+wIhE/caegwNZZQTAQs/vXXIzyqjX7glfnTBdCsuhydP8NXt58lRqP+qtRUe/
	dG78IRsb9D7s1DA==
X-Received: by 2002:a05:6820:984:b0:6da:82a6:3a13 with SMTP id
 006d021491bc7-6ef0e9dc4damr8661799eaf.28.1791923494303; Tue, 13 Oct 2026
 13:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008184328.2857037-1-andrey.misyrov@gmail.com> <irfspelsns7bao36eh5i5gebv2ktqguoinjsvmeebmwpbet34h@kuteiore4fx6>
In-Reply-To: <irfspelsns7bao36eh5i5gebv2ktqguoinjsvmeebmwpbet34h@kuteiore4fx6>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCc0LjRgdGO0YDQvtCy?= <andrey.misyrov@gmail.com>
Date: Wed, 14 Oct 2026 01:31:21 +0500
X-Gm-Features: AclHuK-SxhHlzeO_FcT0DBvs6n2VY866fwKs3FpS2QkVVf-UWDK_UKtl7-bg2Ro
Message-ID: <CAC=piAoYrNzCX3OutKpoEPVEcJmGttTA0Z6NP=vE9wBK=kqPzA@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] scsi: lpfc: Fix use-after-free of mboxq in lpfc_sli4_driver_resource_setup()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, 
	paul.ely@broadcom.com, martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 10, 2026 at 11:19:35AM +0530, Abdun Nihaal wrote:
> How did you detect this? Just curious.

Hi Nihaal,

Thanks for the ack!

I work on kernel live-patching and hit this while backporting the
CVE-2026-72087 fix. I just compared the 6.1.y version with the mainline.

Regards,
Andrey
