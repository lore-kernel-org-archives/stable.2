Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC8C3DD846
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654499; cv=none; b=J+Jxn9M3Xe5293Vggag8gWwKlRk/aKef+M6r59q6yWgDRo877tn4yV7wbWNjePwcB018hZx+boclpDSxJ0FPZ1xlKqcJVlCtFN8wVTRGWoMA20gqgWW8hzBfI9pwhC++RLdCGt0pKz0pCbw2swScXEikrX3oRK5IDPz9850Ld94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654499; c=relaxed/simple;
	bh=hahBDvNNK9bmf+J+1mLPm1zpiT7MVEDng4SYTeyjc+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdCYLS2CxrU3KWZvpfuyXCWFyiYlj023nqdH/rOi2DsIYj6vG00Bu0P1/tE3EUFSmK/t+LkkcqX1IfrsGaoPznzMvOnxAwDBfzu7eRPmy41UTgBzSpKtkaBoKX3ZVGucQ1T6zRJJE5Y9oflDSzWamtCXH5GIDsk0DClxOymp/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kncDq+eG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kncDq+eG"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3902916a91.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654497; x=1788259297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i94ULdmETnrIASkMFNvJU80RyFfAFs6j38sYTnkUaxU=;
        b=kncDq+eGOi/BAhqmvpqiwbq8HDpd5ko6wSH3DyFlTyIviK+MBbv+vkRqOhEBYE93fC
         y6V/kMDHxHzOhAdJFf0EbEVFCF7m6MD2C3RWCqFTcZsmUQC2EjD5k8R1N6NnnAgyoYJ+
         2M/5jxPdPtWcEVt+F34FUiZcmJwR5KZSamoPLVPSWufPDOxQFFUB3h4PmFyMHSQ4rjmC
         Lrz0hK3cZUQ3Nfo2xwoDTqrkZz8GAHT5w5wUFoB7mP3U6A3xaBazpdBveaxT1Uqd+1ZU
         WYXwYxyGOt9pYiA3yR752da/wfWyRBQFKAQ+uxRgMOYqwzZM7EldkBltMZED5SvS5wOa
         iVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654497; x=1788259297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i94ULdmETnrIASkMFNvJU80RyFfAFs6j38sYTnkUaxU=;
        b=sEY5PCnSMN0/0ykgkIACa3l7ZUk19b/ANNapYr0/nfpguSATVFgJiX38aD46ZT7CeZ
         FFUmBzuDBNfHEK+OumXYL0tpoQ6VeSFzn7bdL+UjN7wrE+WI10t7GYh0DO07XcGv+6nA
         3D0eiMF3fM6L2GOo4NWp/rQIKVGrRO9qnCRouYyDUL6Ei3ZF+Ex2AZ1WDZMMLqg3fSU3
         +jDMLmFVxUfNXF/XzQazblw43MoRFk7SHsMjqKTzQQPfqWpLrOEZFTofTaUNbc1Y3rpy
         igwCCRnxfSCQsHcX0doUCR8q61sP6nDfQGYjN3qzNWGWrp7h8GL/ESb0DWoKmRvEN6MM
         KVxw==
X-Forwarded-Encrypted: i=1; AHgh+RoOgBDQttejGFmlwJ0PslrugLFWMyUhZbdHu/OaRlsMdIurQ3k7tuX5iYqBX8/lg5ayKk/HXxs=@vger.kernel.org
X-Gm-Message-State: AFuF++nzhBkcPsc5NzbCDCVyop3MQHVcvKSF72wa5Iv4rVx67ZwGhZCc
	8GeZlYICOCqLYPhrit6bwRJLAQ4JmI1gf66zDUdQlcsDI4jz/ZW/BvnV
X-Gm-Gg: AR+sD10US7RsFiinECxgWsIlOcEivfiCdT5P+vPpBNGHlrErhUsOiR8LVq8KCmEcXvD
	wTXtJrwhhkvxJkzQLq9rq4kSKV2pZqt+AorvU6lw4AsTJyFF08Fw13No/3+VwbFxI3IDmWmo2ju
	QADR3+3qcWGaPNtK2LSWcVmtxs8SRPJLNDKYT/D3+j0oOQC3GJBLTQwWXHQFC46+XEDE98K466C
	rsFEnBohC1d/eWclNP6+9yC1H321dmh+F3/XibJzFx5TjdECwl2ZOCliOQUoGwkTaLlzsRRc9ah
	qu0c/PEfJ/JQ3L05v9kIdbSR0o8i6kGFebNn8grjkbcIr45Nz1ZojR4H39EOvlD8+Rs0o7IcStz
	32Rxjl/1rjrlkxzw0qVcim6LKMdWxnyM/vqbsDKGKM/v9iHHam/7ABjS4lX3ad9w8tHMQifyo/v
	J2gXB+QLS6KpnI5uhuvKcOc3tDJKHIiJj+fG89t1V44z+1NIE9SrIMHQN79Ry8rgOkS1vzWTsPR
	+mBAbU0FJqD4yLSJFLieZBy1Z9KEggWlEzULvcDWJSXC8GU+IqLOYrzn7lUhZoUoKEUusqLSsGP
	YYfd5e/EaR5u//R5MhnWssNr
X-Received: by 2002:a17:90b:3945:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-395c37199b7mr64621605a91.15.1787654497173;
        Tue, 25 Aug 2026 03:41:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b82847sm3501552a91.11.2026.08.25.03.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:41:36 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HID: rmi: fix use-after-free of struct rmi_data via reset_work
Date: Tue, 25 Aug 2026 18:41:31 +0800
Message-ID: <20260825104131.14926-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825034854.63555-1-98lawweijie@gmail.com>
References: <20260825034854.63555-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103144.12356-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
