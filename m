Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C17191F98
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920646; cv=none; b=Xqd0rw1Y152e7fw0+1EmWiVC7/Bmu9NjJ5SnbVADTd15VIsmiWZhxlOzIfM6J09FzIZXZQgfuNK6aHuKo1uicVOCo3k7kVZDrzROnyQXxBrRNcHFRhwLIvowl64T7xl8zSnfurRrLpfLhDPlahu5mEKYv6Sg+OArG0/+8nl/d4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920646; c=relaxed/simple;
	bh=xTH8pl/pkhgHglj+EdDSLptEUidvChW4AX+XQg+FNPY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=W9sH+8sXtuu/SeF81TagNtw4AJan12ZDFkB95DZ/t63W1w2t5VjzuPdkruHEMXhQhK/WZ2m1DEswlwfZL0eoJTXx2S+hEnjgxtZ+Yn2goP8+KLZVvNq/1MW5k/oXtJ6JDEa6AXLpv5Y7ggnI8+5t/DW77b0BeESoOHhfsOXwsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKyQg85G; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKyQg85G"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca80d708489so1619578a12.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783920644; x=1784525444; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n42GLElRxWFrSJ2rh+rVMDepVJ0T/L4DPFkt7qgjRVU=;
        b=nKyQg85GcnYj1aEXIEiisMIoam6xWcBWMs6/MdDy6U3v0oNgQ6DGxOvGd8475DzCWt
         L4Dk+mUknV/gVjJi2f7IzRhx3KGvorMz51Kd1aNn+gTQXfuvOhbr+AmUxTPv4osJSmXj
         v/IjUrqDyx3VONIPne9IbUFTdsz9dNBOpc7RXA1X7Gvy6XsPZYTNBubsNzbDFUWrKffc
         2sigJndhrJTIgfnVXqO0ygFYf7/vFDRH1wxJGfNvM3rbTVfTQZMW5PShfHTM8T+uyLFi
         Rdjy/cdE9LgtZat4wv2/eqsd8UquBxgI6qVCRwQYwWidJTY86VjVyaNXAlHCQQvSMX1r
         9DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783920644; x=1784525444;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n42GLElRxWFrSJ2rh+rVMDepVJ0T/L4DPFkt7qgjRVU=;
        b=FrFWKFHGDBynim66orGaUIFhxRPdy4GbIo8/+jDOhel5nmJ5cqK8/3qfUpF+Ppno/a
         sEVPANFfzR1A90nZT/nHp7/Vi5ddAXmsjJPnEY2DSvEddbp6wMMX9qCzLuH6GEauE0T5
         cC5hNrXakDUKE47HpC3ZHa7UmaTGfhGvpgjrOOVbu5aWtNj3qvNi4JUpFWgBtDPrEjcL
         ugL4CuqK0Id+JwlDizwID1mjWVevjPDtDWrj7t10fSkvyxBW+73eLMzpFoIiywkp4EFK
         fTvy1c9dTi3BN6pXPn+pnAhULtWx3CNpOySqzR5TbbhjH9RvpT+0br9QS2Ft97oULVBc
         rrng==
X-Forwarded-Encrypted: i=1; AHgh+Rp8qa4h7kEW0gNGoOte1YF8X7zYb/eiKkk2hI0XKOR7fjHik1aN3WnhnpAyBVhfRf9pm8XvlFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6g8p8QnwHrH7PW6JUNqoYZPlxgbRc7JteZcQowuBqI5T2koq
	JAdBwbfIK42LO9jo/bQWFVGoecgC2B0kPBc+jF+B95fATKfHpnihTEdCsrQeaw==
X-Gm-Gg: AfdE7ckwaSZPI0kSthbqevwzloDheXdMTtR/AV+D7Pt0GFSHekJpgiz2rkwzLV43Z6s
	nPlB1FvQzw3CmNWU1BxYpPw/1zH/XH8E8SdCiX9uDneN98TV7PsLkb8gUKel2aXAxFpfcr8D8B+
	itluyDOBNa+Fi4rSI5vrCFTFMI1VzrnyNVs2C1s3wjopxB9WyzwdQhNHVNdfILmwiXtyBs7XeOx
	ITi6C9zeZm8MWt/m+cNMAvB+X2Vu+SCcz6MEYqq2PCz6jxQm474Bh8lDN68qpXA0h+7W8eEPcDy
	5JiXkRG4COzXMl6eNIYHK70tRlRaNPHvE+0qc8v7CItfakM78O2TmsCtthFTJFCCVvZyne8Z2Fv
	uabh4jxGnJQBQGcwFTAK2cSYcx43Y6FQ2d9KFHL3xeHT1r3kFqWYfVDaW4FGcN4oqf8Tn9ZXpmC
	so+GrPkebWvsk=
X-Received: by 2002:a05:6a20:a104:b0:3bf:ecf8:abe with SMTP id adf61e73a8af0-3c0f049ad18mr13393163637.0.1783920644181;
        Sun, 12 Jul 2026 22:30:44 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8deb2a21sm18756761c88.3.2026.07.12.22.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 22:30:43 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
In-Reply-To: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:51:10 +0530
Message-ID: <mrvvv515.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> Changelog:
> ==========
>
> v2:
>  - Move H_WATCHDOG definitions to a common header for shared use
>    across pseries code. 1/3
>  - Added a new patch to handle pseries watchdog device registration
>    failure. 2/3
>  - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>  - Add suggested-by tag 1/3 & 3/3


Reviewed the changes and mostly looks good with some minor nits added to
the individual patches.

Small request -
Could you please also update test results with v3 in your changelog
(since you mentioned we are able to reproduce the issue easily with your
test code).


aah one other thing I just noticed since you are ccing stable and you
added a Fixes tag in patch-3.
Patch-3 alone cannot be easily backported now due to patch-1 and
patch-2. There must be a way to define the dependencies if you are
looking for backporting the fix patch to stable tree, please check that
and follow that accordingly in v3.

-ritesh

