Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB42264A7
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186562; cv=pass; b=TJSW7VItvdb6DvmWmJ3gWOkjKXfaRVQV30wwcnU/FPWUdjOuLE+B6XrGeQbvw0Qao2A9gm7MWY6tmcjY1jxdBQWBKL+gVOhtpdP41MYPFbS3nAMtFz7kc1Gw3Vf2LRWBTPS30o/JqOehMNk5upMBro8w8F1/Kh+BW1mWocsDfeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186562; c=relaxed/simple;
	bh=VxvVXdBb0Q9qM0U9L+sOJleMerm+22DQyt5XrTMDHw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPpJuxWoRaU6Wochxmf9Yeh30MRO8n7va4Z2gXMmZktx3IfSuhRuHEKOxy+xwFpXei/V2JfdYuEgXMT9IAXNg+qHwz42AVedtCRHi5eGqzJvHYJ8fpzpb6lK5neSIs6jp0q+NDWOQxGeKHkwxYvDybFX01RPo69Uv0K+l6gvKOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvDVNAMm; arc=pass smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvDVNAMm"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5c67e2ff27bso746551e0c.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 00:49:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791186560; cv=none;
        d=google.com; s=arc-20260327;
        b=pthW4DT7VBfa6JK0TkWmNYnxcNiB3NbPY1iWsPMCUFMUhVNjM/BvTaSFJO8vodhXpT
         dZ6AkZdK05mYbgLXoh7Xy76iqMz0H86HA2WIY298DvDHUzzustqqtCO+ImjHjBel9QIQ
         SpOHAopCAdcbN+6f/UYwvXDqyr5tEishsIww2xaMEqRmrrMmL90HSQNdqOz94pRBubO5
         IQPoGk9L+rUmAbBR8g8e/sLlsq0cOUtd2Zx9UigJboYi3dHnDSb/fUUsJZ1oF61IzHQS
         lm/HnbMWJp0kL8t3MItjTjDlgGFNfEukk/btDNdUl8BM9qUqyuXuEOb/QgzA0WoXMrGh
         q2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        fh=JxtzHYjvz2tWKEvtARzo/ew1rPWhATH2H+4F89J/8XU=;
        b=luTDqDKAII9Wz5QAhq4IWjLrPgL9Ry1SsTbBcteu3FSrJ2ByrZ5qRe9nH+cJ5QvrMM
         5TzCvOePY9wq69mIOS1FFM20qAfI7BTE0JnUyXr0j2qzxKHDfl0d8LakAxyqsa0bqunO
         +Sya2Vs15O338dk7d8Ezu93GW9tKcKQ3tLV8NjvDF/rJNVwA8LNCNPSteur+hI27kalv
         LEG9obMNXlufQfe28DgTSITYw1DLqqAUSqZ48M0N4RSD6n69NA/nnzHC0fcC04JuCOoC
         cdlzhNnFS87v++AGRqaSKEE84c/sPe2leAj4pvW75zuxtrtoLeZbgMlwAI8QIg5grXF6
         ZuRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791186560; x=1791791360; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        b=MvDVNAMm5Apco/LvPRu7/v3PrX28fbFvPGHrYeh3nb4EEAWZSoC86rkKMlBN7cpi8j
         OMKIngMLReYrtGl6ni5G0c37L4QxvIYyILyg1wQc6h5qoEBbiHKuPx8ncQmOqjEoOH9D
         AwwgUko+Sn0lxZGsa73Yj1v1sWc1IMBB7G0n5vXlUsr6IdKxHjVvePgFC93+gdrIz4x/
         QB3i907RgwE8o2VYZHPGs7V71RK9yyprbbEwFPhbL1wch7RH2arqEnOUY1pJbrib7/5/
         mFeRYoNDefamPRdh4Mw8FxBmjM5DMjPAsp1x1JgsfFWPve06ZmK4AywF1vm4RXm5pGkn
         XzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791186560; x=1791791360;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qEOr2I2L1ST7P1+/bhRodaAGlocW7FV1+3SmlS+kLII=;
        b=YUP+eUq1hq/KrroNm3XF72s6C/x2Fc2HpNeh79z5wWbTAZgzLjwty7qHjTwCWS1zba
         7u4iPGiKSpF61ScIi2HQz2V5T/8qCUl+xhTo2tOERzSMc07JENuR63lX3iW+RF7wBO2p
         r/I8PRZY1MSwCO2B2qy2AeGUq1QCb3a2BmzcoeIrlHDQEyY0MvLcWQ7d7L8UfDxImaSM
         b1M/EE/bgMugwyGr/EHnTeRirsD4FjmWUjLnX9XSStfPuFGsJKgPUECKqTe/8df0EJAl
         OoJP7chCb3HvQtjDCIORqv1OV4dibU0oDYrhUfIYrlb+5WlWLCMrQvW6CNd1NPlWh7nu
         ogYg==
X-Forwarded-Encrypted: i=1; AKwUvBx+b3ky5ZJNzREU9gvfhPPjzN2e6Bwh2Gvs7+IpPaAHYtlnWY2bFA/ehKn2dYF0tNyZU6RIDMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPKrCWWYBN9nxd/ltRgDbwd60+JrJGUHBHTnuK0YozpeKwkgoe
	vMzwcRDurPjXTMwoMDf82spRf1Q0293ZJAYF5DOd9i7OJp7/uVnYaUhBLmvvWf4sXaAyUUOm6x5
	1ZQ6cvwyYMYKu8RM6s65LPbUrcSEvkI8/1VGodkrtdN9a
X-Gm-Gg: AYBFou37Q0xjSMd/OuzfA/zhfaPEhvo4T7LWTtf0rK98TcRN1s/E/IoVR7FtM3xggOS
	P6sHCAJgfaVe/3PdVQjNElhsZOl5nX4UDSvQHRDcHYgjqE9RyHtCiouEvHMyCJn4WinYAbZ/74h
	l/03Bzt11w7uIcp1HTTjoEA5tHIjYreWFwo2+rYlQM/oCrHPGdZNcY6JvyB97FY3T+/F5JTR2kv
	bJ9tjGuAVYwQAXyM6xPaPqVJylkxtwRzYsHUTelerVKRIu1sMvUfu53ouCELLB9yovpXnPJ1uk/
	Uz52ljabIlfB9S+dpVlNCv51Ok6PM/s2FoS4GvdWs+wTsN/WLLiFWQy6ZgQiNO6LsZ1iELA6k3+
	FqhlKDTcYtujfAzEKCfnir1eySTGdTZwTT/FCROGLFXUtJIVKqtYq9kzAcHJy82/ylkoaBoF3zX
	VQV4y2PvmrRJLgZHEZGxpOx/sy8OCz6gjfics9TPMXYJu8bHDwwQQ6l3U=
X-Received: by 2002:a05:6122:8715:b0:5d2:f636:7577 with SMTP id
 71dfb90a1353d-5dab041c44fmr2930910e0c.9.1791186560164; Mon, 05 Oct 2026
 00:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-a7ab598efbc5@gmail.com>
In-Reply-To: <20260930-b4-elan2514-irq-route-v1-1-a7ab598efbc5@gmail.com>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Mon, 5 Oct 2026 12:49:08 +0500
X-Gm-Features: AclHuK8DOWIEo0q05q6gq0-QkBnvI9dA5B05mEZp1IjaXwekuF5jwY5vqNmLm1k
Message-ID: <CADeB2Yob9aevFYWM6QaFLybHs+5Wqq4UqmJNNQ3Zbtnz48VEGw@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: iamwaqargulzar@gmail.com
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Additional data since posting: the same firmware bug and fix were
confirmed by other owners using an equivalent ACPI table override:

- OmniBook X Flip 16, board 8DA1, BIOS F.10, ELAN 04F3:43EF
- OmniBook 7 Flip 16-au0773cl, board 8DA0, BIOS F.08, ELAN 04F3:43EF
- a third 8DA1 unit (BIOS F.10, 04F3:43F5) shows the same ~620 IRQ/s
  storm

Correction to the commit message: 8DA0 is the HP OmniBook 7 Flip 16,
a sibling model, not a second board ID of the OmniBook X Flip 16. The
DMI match is correct as is; I will fix the wording in v2 if one is
needed.

Details: https://bugzilla.kernel.org/show_bug.cgi?id=220854

Thanks,
Waqar
