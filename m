Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60E3F788A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789214347; cv=none; b=WFypuWwWlKwvbxLecVTwi0cM9UAjoRD92/L7SOvnvKgAmNMJPDYVrx/k22VZTfGM8gnAiojCNnt4lqfgjo7Mm02fPWapKM29Uvzo9cwQh+6917oDwpLAGkn5w7bsPZ0Yspl54f5x9ORw6GZyVW1wkBehWKqGt0VHSuFBVoaTU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789214347; c=relaxed/simple;
	bh=0ZuGPaqm0QXvHAJSgGG8XUirFZhsJdxsY9E+0TR16PA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=CsYT0Xj/EtwMb/eYdSaxr3UKYSGHETAMUdTDpXfZCgxT8IbC5t+5F9a63z7NaFfvM4aLCug+dwWvqwfS2uFLWTUxQ5iM+8Wc2N4KY679ZOI5MSLodmhZlHN/9BPv2b5j/F/WsYclkXwJrd9kx7tGTVfp7Cen80vv5AlTHSgpfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=bABz9jA+; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="bABz9jA+"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so285369a12.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1789214345; x=1789819145; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ENBJc8zZJdw8LBwxpBXA7osJkWrCLs+xkabhXAApVt0=;
        b=bABz9jA+U11hfXeS8jOxwTp30eM+AvrsLE0fn3My1WzCEUIVPMURunGIhdb0+TMLSI
         30HUC7ocYfAyehO1ypAD2cfYM6sflxlVr1pZ/u2CzjLbIwYcRQATCnEpzwVEgQ8e+CI/
         0M96+FuuKJpNaTMMLFMPgbdDJbsiIu6JmKDBadYbDUkqKvKnh/Szl15vN4QFrV8l7MFl
         AUO/hjte9ezUM9LcDg9WEL2UOULqavjMLoExYpjFNbnsSqPbbBocLoFQ9Wg8tK/le38I
         pPs5NQQBBXjE1tvfP9/elZkhsSmzp9w828gbjppIb3mxZ/DB0sBkKU5EhCxGqKHTDbd0
         KQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789214345; x=1789819145;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENBJc8zZJdw8LBwxpBXA7osJkWrCLs+xkabhXAApVt0=;
        b=kpzhUXjW/Ib1MrKs3e5NNzHBM6g8dKSxc2rH0cPYlLNOMuv2pVhAVmk9BXfWPDisdg
         4u7IZY2MYniVvDYYjRa5RbHR+rV5+9a4e93x6Sp7RlXGMtpYsHCbL3jIhVLJUoMP85l7
         5NxMLo4MlvfEvDajSWoZToRzYZoSOPGPBt+kEoUSXBP7GKMI6Im1tF3wGGfi9E9nGp4o
         4AJq1jiepihRV9zlSrfxptZzgMuVS9kNJTzCmyM1fOTsk4R9frUuK1FzNXSKWktV0L0M
         mn3icXdqpUzkYa8fgXMOxlYt5/tO5XrulmY+wd8Z1jL4e7jSTvsbjL3mkxCTUFTffORc
         EiYw==
X-Gm-Message-State: AFuF++nfHE1FL/eQD2Fo5fIbunkrvOSmruGZKwJTTkl1DCVqEXl4ZIrj
	UnUZABXR8Txom5yMj9GjkSZprMlBJKuRqmu93kXeirJmLQJK0FJp01T/3fzqpQ8IN8yC02OaidR
	6u3jw
X-Gm-Gg: AYBFou3tEHnFO+n1mc9GUb8Z+fN6u6SApMPUDRrB6P8XTXHpzrcCJZpuYg0Q6FXFsYu
	MWJ2tZTt7nID0bBEOXuIg2uC5bllvIoAeAefynsXy+fbL2xtlyTz/W6TFtQBhviBTTBoqASciUH
	pLR6bbRZH3C661x7hs5YOBQOolADuohIzSBhYDb8ikQjyzv/H6UVRsDayqd4JpPPEw6fY/DRQD9
	fjdszwfRLWG6LhRxGdcsWwtriTmLTZ7TIPrppIGxP25pX8VU53wwi1LgQRiVo7Ykp4zkK4P4L84
	hNQZFczE0AAnHfYse4nRqz+qPSAUTDBF9fOZGZdVS0gaEYvGh3d0T50NE2WMHMYplGUkfDfnT8f
	Ou4Z9UEMQSGlSe4LBcD3K64Y8DKn0TeJn8vfjl47aHd5B1Clevv/8S1VKdUHvE3sv9PgHTDQgcf
	u5vsc44zHnyD5JniiWFJ4rQxPf0nvcPth4J6FB+XRwDaMtbRCkfWOTL3YAktzqoIQ=
X-Received: by 2002:a05:6300:670d:b0:3d3:ae1f:d7f6 with SMTP id adf61e73a8af0-3daed617e0cmr18134483637.22.1789214344987;
        Sat, 12 Sep 2026 04:59:04 -0700 (PDT)
Received: from 41049dfc76e5 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e95075sm13351476eec.11.2026.09.12.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 04:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E18=2Ey=3A_=28build=29unknown_?=
 =?utf-8?q?type_name_=E2=80=98psw=5Fcompat=5Ft=E2=80=99_in_arch/s390/kvm/pri?=
 =?utf-8?q?v=2Eo_=28arch/s390=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 12 Sep 2026 11:59:04 -0000
Message-ID: <178921434350.99.10120184293925902866@kernelci.org>

New build issue found on stable-rc/linux-6.18.y:

---
unknown type name ‘psw_compat_t’ in arch/s390/kvm/priv.o (arch/s390/kvm/priv.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/arch/s390/kvm/priv.c:757:9: error: unknown type name ‘psw_compat_t’
  757 |         psw_compat_t new_psw;
      |         ^~~~~~~~~~~~
/tmp/kci/linux/arch/s390/kvm/priv.c:774:22: error: request for member ‘mask’ in something not a structure or union
  774 |         if (!(new_psw.mask & PSW32_MASK_BASE))
      |                      ^
/tmp/kci/linux/arch/s390/kvm/priv.c:776:30: error: request for member ‘mask’ in something not a structure or union
  776 |         gpsw->mask = (new_psw.mask & ~PSW32_MASK_BASE) << 32;
      |                              ^
/tmp/kci/linux/arch/s390/kvm/priv.c:777:30: error: request for member ‘addr’ in something not a structure or union
  777 |         gpsw->mask |= new_psw.addr & PSW32_ADDR_AMODE;
      |                              ^
/tmp/kci/linux/arch/s390/kvm/priv.c:778:29: error: request for member ‘addr’ in something not a structure or union
  778 |         gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
      |                             ^

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:1fa69b09bef01f4b5c57852aa20a6f440e93a4e7
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  bda8b5c5a396080803e932a0e33491ed00932ecd

# Builds where the incident occurred:

## defconfig on (s390):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6aa508f520239ade90292a24

#kernelci issue maestro:1fa69b09bef01f4b5c57852aa20a6f440e93a4e7

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
