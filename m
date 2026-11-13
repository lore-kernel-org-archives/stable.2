Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560487;
	b=WzQtEfY7Hpu3MvxRSORP34PCuKgvv0kT2VnFwy4OSiGAUogsCih7HqKJBwsI+gSRpngL
	 JBRpLswzQnm4p93fHu2LI8GIP0+VNRXxcahYUlqVud+UPx91BNccRw3HUvAyY9VFja/pG
	 KSXcF1vRviPXbqcHI0Fg1nuZZj0kdD9gfWqrwpSS2XxqffVFjSegXxKUF++Aof757HisL
	 rnTQry4BS+vvgHOCMRkJpkrl30KJunXkCPtkLgpSOrIVB6Qqx5kmC3YecQtJidu+cXaBU
	 WOxWz82bf/JZM63LUkNOj/xWQphvqhxlF8LKvrgWYt1ToQhvzJ1H0+CfL7yrOmjWnYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=E3a97Mkr7cqGGxSA1yo/Xc4eASuJjZXRMaeChH71cvE=;
	b=JvQESwnq6UqPn7usqAym/ROhQ/qgKmmKVPKh7yLtBLVljEYA2nySFohvpTSzOFRLQRBi
	 P64X22gWwA6uVv5+B9b0fM8EE8f+8BbqlObNZ63EEy9MGDVc75EU/vaCH3ruQcgcT4Mnk
	 0uFoq3JucmtpZVlGWCGBbNcVAxK8fbbV/PB+KOlG0to3zlpFqR6h7LEBbe1y9nBroMaE/
	 kY1pbOTbTBRM+gUPC+Q+NkcUr1Ul4NGTov57FuxcghQdAbg9IcZ3wqhApKskRE4dUrpLj
	 rrL/+JfKAzF+vMY4GxOdiVlkZxWCdDIf4bnjgqFDiVCdnJ3lX1ZbQPX5MDXU+FLY2kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNZuCq0z;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8898606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8898606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNZuCq0z
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so2219885ad.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794560486; x=1795165286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3a97Mkr7cqGGxSA1yo/Xc4eASuJjZXRMaeChH71cvE=;
        b=kNZuCq0zNrhjHBoGvHgoqEvu7LGBEuwEdjNIy7eUNd67NKJ2NyxrR+BbOokPwv/wpn
         I01FTR0qFkGM36MV+f0cjh/1T1j0L8APHuN8zQ3iBJjNcZ3wRKz7nFsQD4pMJszQrTQh
         PzMWGbQo3Qn6IHI4Dn9a/8QDg8uz1olXxO2UsF6/PWBrppuqR/GDKd77tcUz4xLXx3iQ
         pUJH3+a2cpB2hbFyVGcwhlqcUutKMwX01H2R9uAsWW2lkcGZhHEsFEnJLkCbEG/FXkId
         KE3dTzzb7rUkp/iCDRK3v4cj6d2FTsKZSc5FvVAkgcblXMCwcsXjYkKeeB94b9oaHaON
         aqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560486; x=1795165286;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3a97Mkr7cqGGxSA1yo/Xc4eASuJjZXRMaeChH71cvE=;
        b=oztGSlrPd4Nl78Yg0jht7BE2t7EJMLK0tU3FS+Xze2kEyRhza4nuBDpCcxQG1wH5ht
         h12FacPRBkO03PdnKfPPuL4Gaww8d2x4nB68nOkqSWn3SwiQ7coXDwgcstcmDnVOBrIM
         ZDcPZQA3B8BbwsZ4jGaBHoGhs1YKyoYHGkzYQSH4dBqxjq5VIa5cMTtZrWqzFGvDDeVO
         ZC0F4IUUOBt+oKPHgkbODseMeow8umyTQrN8EwdpNG+Z+3lz9X3nx0XPr6452wyTU11r
         yLTBfdT+T0xxeiMknneNDX4aK9r7wCn7bPyReuN7L7xvg7rPN3nzwxKYM/XnP9zjd60H
         7KXw==
X-Gm-Message-State: APuU4Z9yRTGoB1F5VYR+GPnBVSFYNw4r2UdKVhDjMpNeLIpza5v9Xtm+
	taeleMSK6HvbniVgPcRZLYT8sVu7SIr4TDARsAkYEUkgA4nMcrtC/+/O/wr7Mw==
X-Gm-Gg: AYBFou31zC1w2Q6KDsR/ncv3/zhME/8ECxpYNatSRu7MuUAowFN7YW4bHDXVe52sTyF
	xxtxXG9+SPBPmc6qbu4bWpZroOTEISobpinFayN8yWqGBl3LploLZbD4IqoDnJHYBBdUNoFlUoS
	PLaQvFpSqsaFbVB+2SqZuQwGKFmr3uBYTCkrQKL0h8NW7dxZZ3qAGyxAx+PdyrgvbVQCCrugAel
	q7o8isR7hUJ+2dfT6lzKY3jLNVJF2YuRqVpH+Gv+QpZh+04F/QZyhdt1qA/laCmu6j7U11Em6eG
	JR54t/vzN1aWYeYS6UUS8DNfS5ljUb3OJfsDMwlh7BdHC2sut7vQR7GHck+mMJnmarU1xr+eVs5
	xWCGghd3H0qVSs1L5H7292VbcchzcL/lOIe0Ksiva7ei1QrSA9Ty24bQqqrBTtUZh61nWUHYYlz
	4tye60zz7bWr6PAYtl6EprwJ6n8GeJ9dAaIEtRn0oaD2XutOQh0ylK4Ma3lfftI2Bf6d0lnb93F
	yDiayo/VmHFyDQ9FMTHQ5SidCSUwlKXW9IPkYqA/itb22LnNI3Wi9Q6/ReTDHj3CPfdctQwCoPk
	mV8NGSoGxDzSna+iTiM5aNwbD5hKeb0VRTQw9JA9w46A
X-Received: by 2002:a17:903:3887:b0:2e9:528c:ba02 with SMTP id d9443c01a7336-2ee0dcca259mr16655485ad.60.1794560485927;
        Fri, 13 Nov 2026 01:01:25 -0800 (PST)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8d708fsm6770405ad.58.2026.11.13.01.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:01:25 -0800 (PST)
From: Vernon Yang <vernon2gm@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	liwang@redhat.com,
	jackmanb@google.com,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH 6.6.y] selftests/mm: include kselftest.h in vm_util.h
Date: Fri, 13 Nov 2026 17:00:59 +0800
Message-ID: <20261113090059.380783-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

commit d8a866c766ebe34b4371d42f4a3edca200f5e645 upstream.

The 6.6.y backport of commit fdc3bc349794 ("ksm_tests: skip hugepage
test when Transparent Hugepages are disabled"), added a KSFT_SKIP return
to khugepaged.c, but the prerequisite include from upstream commit
d8a866c766eb ("selftests/mm: add commentary about 9pfs bugs") was not
backported.

As a result, the selftests/mm build fails:

  khugepaged.c:1195:24: error: ‘KSFT_SKIP’ undeclared (first use in this function)

Add the missing include, only the vm_util.h hunk of commit d8a866c766eb
("selftests/mm: add commentary about 9pfs bugs") is needed here.

The remaining hunks depend on commit 32b42970e861 ("selftests/mm: skip
gup_longterm tests on weird filesystems") and commit 571a4b62ed63
("selftests/mm: skip map_populate on weird filesystems"), which are not
present in this tree, so we don't need to backport the remaining hunks.

Fixes: 6b117e23481d ("ksm_tests: skip hugepage test when Transparent Hugepages are disabled")
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 tools/testing/selftests/mm/vm_util.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 9816d6e9bce6..f14ebc809585 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -5,6 +5,7 @@
 #include <err.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
+#include "../kselftest.h"
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
 #define PM_SOFT_DIRTY                 BIT_ULL(55)

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.56.0

