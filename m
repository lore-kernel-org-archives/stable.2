Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF983DD84C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654439; cv=none; b=PeL/SOX8fw5acb3cRTrMzXnjaqXNgFxSMveca/s2v4iRPVi+EPPN+HKIwiGLN6BQXSrFMqCHaDrXNjBgOfK2zoe9fN2lq9REjPOzOnKu710GsGpJ3RlFOaxnPmlcH0njGkFwKHjK2Wb/fLY8CYhwK3rS75MYc/5sc56TrWtVxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654439; c=relaxed/simple;
	bh=ioddsn5yt5I5hi2jejY9A5CM4bUaACPKih8k4SZvYyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7qLERQ04scuv3SB3UGTplsfgbDn+8CXMBSYwv0UBTxivTF5Meg0qL+bcQCHisn8yVKlP5dxQAjN9ZeoGAoztoqqPk0zE1kej/InM8N9q7V7OjYpRbOUZtGfqS+IDs0lRfZSGE8cf7r0ECNPBmUqPRmsYlzsJwLFKKk4ha06QGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZF4o4ND; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZF4o4ND"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so52734575ad.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654438; x=1788259238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjJwzyc1eNDpSGhDvSYntYVlSmXkNY0hSMehMAVhsR4=;
        b=oZF4o4NDXOiuxSoztUcgF1r7C6Uv40N682pniJ5aEjyK/Va/PhgIcufCOykTTCnrjb
         +mD03rLa7wbq5pAmUwrafA1t81W5hCRnM/Gj30n4gDnEAgz7MX+otyaVIcBb5TuFiXDW
         Z4u3TY5Iwoae0hLoOD52WPcXnO6tg1QxSvMzq1AssnxIhAACV2MP8FZf+hSeJD8r/MUt
         h/4aNHcHnPeGOvGvjXZqiFBIy0TKW7y1Dm4u+49xbFkQ75lyLwqx6G2YqjDb1VBJpstn
         w6FfwCNDtxeNSpHmb7eDiFDBBynD4rp+8qPby9BFnfoJRSCyx8kXRWdTxUnSke+9465O
         /TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654438; x=1788259238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjJwzyc1eNDpSGhDvSYntYVlSmXkNY0hSMehMAVhsR4=;
        b=evckxIKxz9QS7Cm6sWnS5r3tQlGF1ApXsHtNJ5pu8dQuJmTcO3FlbgayefvXic9iek
         C4WsgWoo+GVL2dTymD1KAX4ucSg1dxdS5UlQcGMCZC4RV070h2P92UxmbVLUmw+BHxew
         rWXhQPwA44JB+CaoUb0fDSpPrKrKFacdJLYyGQLeh6T8X5guD4uY2UnTCBTAdO6GrrTJ
         fOYJw4AY9yy5yhjECf6vMjRyk87729iVuMVaHGQOSdb9ePkbnV+ycZI0oX+O2Gx9yGLN
         PoJ6ii7Y1AyoandkfQOm00IrKVp4zURlhd3JezL3OV0+cTkHNSj2Y+QunTj8jNfI5a+/
         YAtA==
X-Forwarded-Encrypted: i=1; AHgh+RprJYQUBACyXIhjIbxkuUEzSgXGzKYgiELDpdWTWAfHaZ9MaLUEUWUw7eb/qkJm7cSzhdqOXY8=@vger.kernel.org
X-Gm-Message-State: AFuF++n+FLaQGCVS4eIzP7baspGe6Quxp0br9idssa3zI7rmTkRbuXcr
	eYTg02vtkGmB7/MUFKF2L22Q/0VMUIzPoCQyww5EncE3PvTzTWFJGadfzr9xR4FLIBg=
X-Gm-Gg: AR+sD13f/w0tVGnDuT6eoKK7dhZivVphJMioDPDTkiXIutFjsqTMIBySYUBX2qPanaR
	Xp6ZaCZjj1Y+javWqwaFm0G1yz5RyaT7VH9rxw+KtX6Dr/Ten/4PMEWN3GKYpuG6t+EUKrIJDNG
	rLT2o2icy8PPUQqkCyUSU0vDsVjP52IKZcCmz8k/L1guzzO1ZgaHKwFAmMsJmA6hFX0pNktVUhk
	XtnEWhCM82CyX/Shia7Aj3eOSZ5g1Nwtnirm4Qmt8sbeIvpAPgP0LdsxUgzLM7AAz1QSVGIaF28
	t1vjLO1H/3R+Hba4LVoUzO6+ypykEdL12cxPG9nfOPnUfw6JjsIAn6vhW9u0Kr+nAx17wssWqq7
	6dOdPqLx71ws1WfP1IV5PPiX39n3e/RFWkzHE1qCdnrqSs6MFP8wYHbXLIGI6pjmC1Nlut8WcCz
	/JMEqycUDsFwvPJRJuCiXGvadJSBoIq3DUwvGEfAVoozwe0r1hiQUlpMUuQ/G+hFXXKKxyFAiiF
	iq0Hf1N0oOd2sUQwKS0iINvFUnOKT62DyOre8Gz89FQ9rngf1pOudkDKN1b5vIDtw8dizMdVaH4
	A8LZGRL+6DOa8AZMhQGJQzSo
X-Received: by 2002:a17:90b:5485:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-395df6080e0mr51290530a91.12.1787654437517;
        Tue, 25 Aug 2026 03:40:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39646138f87sm3276991a91.3.2026.08.25.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:40:36 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	cheiny@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix input_dev->name use-after-free on unplug
Date: Tue, 25 Aug 2026 18:40:31 +0800
Message-ID: <20260825104031.14644-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825031315.51860-1-98lawweijie@gmail.com>
References: <20260825031315.51860-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103139.12314-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting -- plus a trim of the commit
message.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
