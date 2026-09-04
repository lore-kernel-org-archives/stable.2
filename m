Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DAC358378
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788487372; cv=none; b=hvXZfbHxtnGgD9YB4KSmILVebEemwTvIzZu3RPGk7IziWs88XlNmnvk03MbSyg8ZFNRticV93S0bCcb6vdUOWlVwTr5faGQe1j1Q2FzvutGFPHNeABaB90xLeLsxNw8pJEvP0GjNeQdEoDsyEdEveZ5zRW0coGOYnqXe/BAdv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788487372; c=relaxed/simple;
	bh=34Z8DPG6Kp1PMhLkp+d1BQuCa8F7adfXlCWa4tGzx7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBZIecZhWgtI4xCeSxLHS9rkpRhAcKgyAyWEA1uLN6W1AeiL/rNRkYQ4Z8Ki3lzbqxIGMDrNCDH8fiesgCdWrB2k8IBDTe/qaDeJTIrXWOUo8jpd05zONrdZy7N6p8ikD0MMZEKlNsjZ15Rw9FZTBhEOlh0rtSI0nPBefoXFdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTY7jrO+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTY7jrO+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce98cb8165so5670665ad.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 19:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788487368; x=1789092168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34Z8DPG6Kp1PMhLkp+d1BQuCa8F7adfXlCWa4tGzx7o=;
        b=LTY7jrO+vAtZxmCQ/C3ElmbukHQTIoTnnF7+J9gmgB7AFCx6FqwTZFWEltbwc4IS5E
         P+zrfqDAD/e0TZj4bde38JQZ3ZJhw0kd+RXDFKAOo9huVWVPUD5sd8Xw/kE/Dg+tJE6y
         6ITzhAVUiWUJAAZHltlM80hqggESApEP7jeVpUML64L64YPc3aRMM0HbjU8HsQo1cS9e
         6qfgP5EboopO9uIrg9C11mgn32S1NBf4cLrKp+5QWM3j/O2iR70NabmgDLXUsHxZ2MY+
         D/NAOX40ra24+SNevUFSkDNiA5YFcy/68WNizwLYHbv1xewOvLBr9GRFFUhW9QY3rg6l
         juHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788487368; x=1789092168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=34Z8DPG6Kp1PMhLkp+d1BQuCa8F7adfXlCWa4tGzx7o=;
        b=QTAezfCmhxb71JtQfpaD9KRg39jnqVzZyr3Yuuf8hGG3zyDb7OzFS6ibVHluuwXtdL
         STnPsBQXBsa2WTpHh/XVWAj/+2+NUgOVftil7+VvkVxby6Rm2kUv7ZOYkdoWYFDZNOyz
         LkPe58z3q+Da9VssfTZfmpHUIjJFspIp+ZieKaPMSjS71pUNsUepg8noKEiEVvTATIDw
         07IqZkGL4pmQa1ePVj3eHuwEtDQY6EuVY71/8wuQhkt1vojesEXxxgis0ENZ6RkaXGfi
         CLCVvcUoTwmG58w2RSCzsGoUxPSJOqecYuheheFqX+iNl81yJJ5RQrTbuANIQGgbN/G7
         p9Cg==
X-Forwarded-Encrypted: i=1; AKwUvByeHAIOF+EpcHhagwJSFbSLIh9zcchZlFcTcHaNCNWAQO5i0g7a6k8lQjSjC1r+AfCnaiL1hHE=@vger.kernel.org
X-Gm-Message-State: AFuF++mxDGBMRMOHpPDD+WyUOtmJt2It/P+Br5ebTJUQK/W9n5asQMO9
	X8L1Zuk8Zly18pUXc57m9iI5v+Tqpp1YFsQyneLDllbJnqnnb7ybFSY2
X-Gm-Gg: AYBFou3zQsm7HrCKtUJ55V3drSGT8L29vfGfPrpGR6e9brUE4RFiXa53ei68vrz7ne1
	Gacv53laKA1TJZb5GIwsD+EZqCshxccVFW/SaMamBemw+/J3WeisZCI3UMrSd2rgnbPzybnfn63
	IOQMDeNYkpeVU2W2LGY0tckgwxaMg0uDJx7MFKyc0DQCuQx13fN/JOsZyS11A2LQZ5PcHoOuAsy
	bRdcYhIbIEL/eAslyW+CsQ4oljDr0wUPVtsEcEiltwalT0gcZYwe087Y2kx3iGPvHw0gtflKOoj
	fhWbE3IVVaC2IArvCPc8gp+k6acFl8VOQyHIjP5AGWa1EziqZqhYtuC2GTvpLvA/Nq9qNHdANjf
	Pvv/hMrSGi8fOrJ0Fk++6x0aLPc+oUjoSDgz/eUrtKRcVtBZvBnYpMwjuVdD7ITtt3TMvRwGJth
	zAZanSoDbEsdb+az0slkup0MNsFn55cM4kGUHA7DqCpxkI19mctyv9o+RSC/+rfPNGQ58N8Yc9V
	vb45s8sFzggEYxF3sa/w80+IAp6VWc7V072ls88AOI9Y72cm2Wy+TMK+jSIeYFX+3+aefo8
X-Received: by 2002:a17:903:8d0:b0:2d6:fddf:a890 with SMTP id d9443c01a7336-2dafaf31cedmr99763755ad.6.1788487368267;
        Thu, 03 Sep 2026 19:02:48 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495acf7sm2983195ad.25.2026.09.03.19.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 19:02:47 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: killertofu@gmail.com
Cc: 98lawweijie@gmail.com,
	bentiss@kernel.org,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ping.cheng@wacom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
Date: Fri,  4 Sep 2026 10:02:35 +0800
Message-ID: <20260904020235.8227-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
References: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


On Thu, Sep 3, 2026 at 3:36 PM Jason Gerecke <killertofu@gmail.com> wrote:
>
> I'm still finding the above paragraph kinda hard to understand. What
> do you think of something like the following instead?

Your version is definitely easier to understand. I'm good with it!

> Other than the above language issue:
> Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com

Thanks. Should I submit a v4 patch with your "Reviewed-by" and the
updated language, or is leaving it as-is (here) just fine?

Regards,
Wei Jie
