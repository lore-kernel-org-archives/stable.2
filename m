Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210354;
	b=xpXTHzUeVwPeJCaVXsXucNAFLELp9+Zu1ulqkjhacUhhix2+QBTDsVJGIOHkYj5eMUfH
	 bTF7k9DSJburGSxz3fLufAbVGjumWF7KXGejP2uh+V/kFmhweqccHzOC6OhgmuVxvItlG
	 QP6iOSZD1wRd9Py+VANlHrKaYqS4ol1ncFj1R4KKTmQhdgtyy5ioVtWVLN0cz/D8RAMQ3
	 gWeTlPsUWdbA0GucHm0FBErSJujYYSR7aYIDRpwM/lDDVzycCrbHtsOQ5n9i9/nOTEcLp
	 WvEJTmnL8BhRuLf60RtgXYwee+3v8LY+3nn234EvkN1++XJ7iIrei3ASs78mFj0tvjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=a0kdzw7ZILvSI+WBkqpzrj04cCXc4beAJsm8i6uf7NE=;
	b=OI12zFhIVeaTnaXj5cMp1r0txPHPQrW+fx5nkOkgUwhz3dvrcxm5Ansp0L7Brkx7eeZr
	 8V0+lM9GwfoKQ/TuXBkUo0MMeKBh+tHfafJF78I9JrCe6NEgvFAtSct5Cz6H4B64ccPaJ
	 Ujf5Jbz3H/h3CcIpca/Mpzh9ZOIKgKlsouoSKX3Z2l5B3eJr5nQcQM4Z43aIyMEq/GLId
	 uaTO9hELmNdGsUMN3v82rnhzgQAXyHeeOmAKMgZzbZxOfJ+MEEqtIV8IrmNOPCbeTTxhc
	 3JzVOUQCsAgMOQI8HIM2O5Mv4ZRocRzl0PgOsZPA1hVcQ0nZtTQV7y9uzi6KTPSJCmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=c1GZkQiF;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F1606A322
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 17:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0F1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=c1GZkQiF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso1488096eec.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1793210353; x=1793815153; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a0kdzw7ZILvSI+WBkqpzrj04cCXc4beAJsm8i6uf7NE=;
        b=c1GZkQiF8qVcxx3BT1LTvz+1Y5q7eRh+eu9IyJJb7Mkry4Pt+2bGF/8VAFhjkt5gcZ
         z6ZKLMemza3rA6H6zgqQoXiI3pnoCDdW7YsNcR0KwKSL29susnjuxT4Iw/y7ihagEqSr
         rs6Z+/p+c9WeG6UkMI6sZiJS4eTX3ev5e41MySNYcsmJ5daIku5+85ldHqz6aWmpo1gT
         CeVrztdmH0oHjn82oORg3NAtj4tI75EKn4RZg22lfX8b5Ml0bcI6Vj1N1hXEqxL7BkjG
         Rkdha2qzMuburnR3uPlF4rEIZ5YXmXpdFD6cyT5r2ZTfMvXWnQOmkYxQUby3M6JyZjwt
         Fdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210353; x=1793815153;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0kdzw7ZILvSI+WBkqpzrj04cCXc4beAJsm8i6uf7NE=;
        b=T7FNxEZBCgG4k8O5gkbzCRh3lfXyicc4BFuhUi1vFv+70lWCjrxvqgXd2Fxip0BPQy
         aT4/oGk3WVT/eZjR35AJV03ax2iZ8MHsIvEEdk22tKUVHp8S4s3IrOC57thh9Toi4mqV
         QcESMfBFdwE9Q+SEj+/j+PDU4QRcc9lnhJmTLJAtPoC5oEttf7rhi9jxwepZjr1qPI1a
         HCIB2Z5lzgMGioBQoP84R+wF6+and+eh4lkPG9Uj49yFGN8KcuTe6fTA+R3wThJAZDMW
         cs6cIfpb0qPEvA/ByWZ7Bv5OyXIGnu7J+emNZXOgm4doyyUbzTZhuKAFLdxPzQNv1RR3
         50tg==
X-Gm-Message-State: AFq9FYKkIJK0aUV9NoFQgCPyGTfo5bRVIkfcjBVfdXdRstyjikfVKmpV
	kmodhxChhZzMl4wuTLCMpUCB20fnHhse3zEAxqjZGXAVPb32cxn2EGzhCyJ22x3JUD8cyDzG29d
	NdipI
X-Gm-Gg: AYBFou0wUDq8c1FFzdcZcc3Nym6njcE88J02+ALXFDHVn1sHeJH34GvNQP9NOOayCHa
	PPTx3taT4iC10oRTn0Gn5iI+ezKRhzuV5s5XiMWoc+Mha9XGzjby6lChAUcmk+GB2O+K7ZTyFB8
	7Geuo89GC9HoZBn0EhwhA8eZ7He9sFm5+uNKfuXLS7NtXww1SH49B0vaL/VzEqYgV3RMtgiVrQJ
	vIJUSG63VOOPH4Dgo4Ou2b0uGuQmgGed13MUgbeQ769GFw/JgNJjuJcZPdFIAPAlKqhTiIH2Hdu
	IjJfatYf4t8pY6tCaPCmLd1bfDzcKy+NOI7ov6pxA6R7FgrlSyeknovxdhyq+qAIXleuZ+dMWKs
	37u+f9V/u7FGUx+d6bTXuafFGeazmxStl5ij+wltnkKzfKb6VTm6wEUowEnY+Mx3J/FF0lbeLe1
	zFbkiLco6BKnOmjulARLr3PcRv/zzCA7AyLIBuxPoDNdyo5uaDRGI1dPaaNwJoHlLHc6pBWTDK7
	q4PNft3H3UAk2qILnaonxIl0J3XMFrP0lSwhgI5VRmdv73+Wh9/Oi3R7x/4A3ol7B8cjaISP+Ge
	LQDZT1o4y02AheRmZx+duQ==
X-Received: by 2002:a05:7301:7187:b0:369:fcbb:4d4c with SMTP id 5a478bee46e88-36a2007da4dmr4014760eec.7.1793210352955;
        Wed, 28 Oct 2026 10:59:12 -0700 (PDT)
Received: from 4cb1f8191411 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239198c9sm8104521eec.15.2026.10.28.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 10:59:12 -0700 (PDT)
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
Content-Transfer-Encoding: 8bit
Subject: [REGRESSION] stable-rc/linux-6.1.y:
 (build)/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit decl...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 28 Oct 2026 17:59:12 -0000
Message-ID: <179321035195.43309.12611722928896027766@kernelci.org>

New build issue found on stable-rc/linux-6.1.y:

---
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration] in init/main.o (init/main.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
                 from /tmp/kci/linux/init/main.c:50:
/tmp/kci/linux/include/linux/highmem.h: In function ‘memcpy_from_folio’:
/tmp/kci/linux/include/linux/highmem.h:427:21: error: implicit declaration of function ‘folio_test_highmem’; did you mean ‘folio_test_hugetlb’? [-Wimplicit-function-declaration]
  427 |                 if (folio_test_highmem(folio) &&
      |                     ^~~~~~~~~~~~~~~~~~
      |                     folio_test_hugetlb

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:9c4fe5dd5eb51606374ab479a2ffaad1139986f5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  406de00ce2971abe3010eaabc26c71e84b4ee9b3

# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae2287d5c0836a8c2f0479b

## multi_v7_defconfig on (arm):
- compiler: gcc-15
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6ae2286a5c0836a8c2f0472c

#kernelci issue maestro:9c4fe5dd5eb51606374ab479a2ffaad1139986f5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
