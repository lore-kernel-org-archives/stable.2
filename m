Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589147;
	b=hDaSGt0HGTYPoR88RIClHpUitPlNOrLhkPO5Msyoa2fegOzwnQQtUCDl0Eg1DGmT270t
	 SK/xHaGJNVNPIt/oIK4JXZcigHyEdvi37/yld+KBOfT44rEkPb6rM2LVlrUDUMEGkbs2F
	 6brmgiWeAOPBMrF/IagrGKRENBME/WriGNg0fpgCbeOtZHDLrtLi64J/36onm/jSY1ZWI
	 M83BLAU8JxwH22nWVrluRVMVE491CGJCo8p9sxDzL2YNTk4jzi4uyJjF6Hl4e01o45h75
	 2ZMk+n7UvaYZyMe6qiA69onrzTqQcrlinA03eNGwneeeyxGSmCpr3BpT8DJdWfEgdCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=MoLrDyTpK9JVXvlO7i8lPdZUMJ4kSTaovGwpnemXpx8=;
	b=H3M4qgQ+3COgf1dNpqN6tyQGcHJcbP4eHpO4Pzy1Zn5y0CiumSamrwzL5W6wMiBXo7ra
	 kVT5mn+U4TEczrM4CyrkAdSEp3MypVXtkk4CKIVJVzTb2yZJi47TbccD5FNdsTyhoU7Lp
	 ytDkfs5uKb/D4dKsRYQICcd8ttSSyRPNgDvijgaZLRNsQg6Ip48jfFSJC4ZMOyIer8ibQ
	 9z2AD8m+M7FWZSUpjObw4RZr8UYcZAVkr2tSOhTOJbFY2ukuWVYCMAAdyWMIWdgIAQvWI
	 rou0GtEugu0lSwt0ApQDC0OO2vv150YV2aW6K327AaA+MeKhD3cxsYwx/Vmya6/YJFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=a0lcA5up;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB4606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64BB4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=a0lcA5up
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae58d17cd9so686792c88.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1794589145; x=1795193945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MoLrDyTpK9JVXvlO7i8lPdZUMJ4kSTaovGwpnemXpx8=;
        b=a0lcA5upjBwFM6/X6V5HvJWgJoV1FmI0vZqpGAZjv2Isr/rqZKIJq2DzVIqWtK2yue
         sHlPut3DTjp0pjtYwZJTXQR4bThgP3WS40R8dZnHV/CHdwrSs5S6FgrPRyOo7VZFSmJz
         SQAEwVaIWJM2t3bD8z7KKP9dIWYjWzTJ97hKz6VsSF4mZUfjAlJ/Bn+NV3zvf01DaU0F
         j2fBYpa1hqod3HsAUfK3z0TStQeOT0jbJJQ3SNDJMMy3vAfEerKb+kHCj6qw9MOM+P+h
         1a8MQHSYPmvPmGZezK/iuw1NTzpw1ekqtcaxg1lQtsNGTGTyzpC9fLf0+KCPfAOEd9JY
         hs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589145; x=1795193945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MoLrDyTpK9JVXvlO7i8lPdZUMJ4kSTaovGwpnemXpx8=;
        b=zhNB63dcu/28Oqp/o6uSe7TdQzWlqlFTJ0/vdQiQcRCe0zX0ZPtJ92OOpILFA9A1tM
         2BHt6/ShiS/o1q7kpPkyfrlQhkv1fss3QKnDLW4K8rX59moixMz+0bsc1F53M3bgwBd1
         dfZ4gCL31izASefOnLPmG5upaeGe58vb7TxuTWIlPAlYRKqZzO61eo004V0qRwZmjvKs
         JpqXSZZklZaHJMAr7yMf79gBwpFo8qvQgYTQKu24mC/Jj9CUcbZvPZQVY4TrRVFU4aF1
         Wi/wICHlYdTggdwpeKc7gXjEFdnMOcouWFbjNugTEgjFcd55lA0e6GRd2KShpK2YbQXf
         hOGQ==
X-Gm-Message-State: APuU4Z/4P46IK8pvkNRrMPh8YRPbV5rFW3pH3RvxC6jS6XJI23psR7g5
	+ECcWv1uwTOVATdY2VD1D4u+cMAW0WjlWjVa0t1S2Cs3iPgSBJ0kipCCTx/+ucHBJ+BzOXEI7Wu
	qJoNJ
X-Gm-Gg: AYBFou0xONwLCpytPFRxwQAs293FKptEuTpZISZABoXofZe+xYKOL+TM+/Dp+7pjzzO
	6HQSzjjbQWBBxP6FCbVXaxNovLIkkFpBTytUTe3QnOLm3wjpWWJOmRnsZth18bEiPou259FLJEg
	TY8CqGA2hX1erIY523mJ2pYB7wrjerGnhUwJ2fPcz/TwgHsRe4V9H8gsU/iDTZtZzwEboJx9Onf
	x6I/ahmvOz9C5Uiqkjsto8LQatzSGuYsVa8CaaGakQZZe541ISuWtoqQ7O7dg7h2oQjRumMy5Rp
	ZfPLPS/JOZQQJQ6oCjwl8uwwIjtUIOpwjhdNDmwciVUoQUerwm3v1j3SfilsB66kEq+gsmEnwQr
	T877uQeREBWJzIFd5kEJtdyFQ6FnycU6o3ScsR4sCUWRf3tzOCHx5X76EkteACzbFu8z9aDYqwQ
	wxhWSbG+Msxeu1zthjirwRVvarJQ+0XHzBNUgASOsIO6xlueCAHUj9hejs18uezlX1Ia6FNPBJH
	BoIf7rebtQCXTpYBi54Y4fqcbixXjT8g5C+hjXz0qoNuM/FnidEHgkumaoh7o1KXw8F/afInAqb
	s/tDlOYmh1owCxpf4L2dAw==
X-Received: by 2002:a05:701b:2706:b0:16d:dd5c:4261 with SMTP id a92af1059eb24-1b503120981mr2699552c88.46.1794589145168;
        Fri, 13 Nov 2026 08:59:05 -0800 (PST)
Received: from 8439c401ee69 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b2b5sm7314937c88.1.2026.11.13.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:59:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build)type specifier missing,
 defaults to 'int' [-Werror,-Wimplicit-int] ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 13 Nov 2026 16:59:04 -0000
Message-ID: <179458914399.43517.5869442967354575360@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-5.10.y:

---
type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int] in drivers/pinctrl/pinctrl-sx150x.o (drivers/pinctrl/pinctrl-sx150x.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
/tmp/kci/linux/drivers/pinctrl/pinctrl-sx150x.c:832:1: error: type specifier missing, defaults to 'int' [-Werror,-Wimplicit-int]
  832 | MODULE_DEVICE_TABLE(i2c, sx150x_id);
      | ^
      | int
/tmp/kci/linux/drivers/pinctrl/pinctrl-sx150x.c:832:21: error: a parameter list without types is only allowed in a function definition
  832 | MODULE_DEVICE_TABLE(i2c, sx150x_id);
      |                     ^
2 errors generated.

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:cb910e76085dc9137fa215cf68d23e9eff539639
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a320864dd7e3be8aba44919f934c03e20b015e0a

# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-21
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6af738005b429d354e4dd897

#kernelci issue maestro:cb910e76085dc9137fa215cf68d23e9eff539639

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
