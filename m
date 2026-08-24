Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E065390609
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787612196; cv=none; b=K2o2MB/d0JOVrrJtvPRAe9S1o2trKRtA7Px0TmUj4EogkNO5i5H2dSScLIEQnhHLtB8r8Yhx24OkXiK+sJDcQMPIn+PK4UZ/g/imgdn46el9JMcp29SnXSOOzSVPkEdbnhmCQyWI/lqJksIps/Vppw5/Z8KvrnKhOW2lRObR+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787612196; c=relaxed/simple;
	bh=7rd4ClZqqN2aAO4/lh8ks3sNlQJRzQxsfCz/FbU/Y1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9RzolfDrvp0E9Jf0W+DOitZ32K0hrPqR0RSMjy5tCRsspNNn2YDoZS0vjnTyVVza9qG6HPjSj+7G4VDozrAcdX8FawhZmx+aG43U+iNYaGSHwjHYI80wAIbD2Wo3peqUkB3wgmRtvF3Aj3SqFzuklMe6ZJ1kfvIUM3y/fuYDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTFX5+te; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTFX5+te"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3964e480f76so124584a91.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787612195; x=1788216995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwemO9iddBuLEZSBsEh4l2aSBmKqvuTPVgJhp4d3ZoU=;
        b=NTFX5+tesfX1f7VVXXXVMBooJCho4uMIYSlwn7uBBQTXTLjpLKkhF8szypruR3JnJr
         qRhNPULBbO2v/LI1DxAU/55UCoI/A96NJKLCey+eJ+/Sv5f3vSXzCpALbJ0E8p22OpRG
         9MObdP1lAlXbFTJI+3toiUWdi+A+gyZtBQrTNuV6yDenW+2xxj4SB+V26jXLcs6mrc41
         ruKpm8KhrkQS+RfHmYDBOnruwtWVPpZ4mpFo0nyNtqA0In1DxOKIkqKKypeYf08KG+dD
         z2/92ifwxYBSaLqWMf8TsO4hIvmrNEc46IvurGCFCUJh/nJRsZBgX070TbD5KIlrsmW0
         51Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612195; x=1788216995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwemO9iddBuLEZSBsEh4l2aSBmKqvuTPVgJhp4d3ZoU=;
        b=JkeODYKms50ul/mAkuuHk0aQOp9bc7d1uUuLv8rz8GjL5/8myDkLBYtqaQQvTimHKj
         1rKHhvoHqKtDd3BCM9ZJYFNsvu8rqCmL6pPvNXIberKz4Gq+j1n3aLPAaRhIhFGtO7MX
         72WTtH/G0CXZgoV2Y2MJkdHadflSezDvPbZM2PzVM8PbnTlsewplVesqfJ+YJZMl6SQj
         4Zekf2Lixqv5c3UF57XsOxJo+i0uOiWrWZTlg19JoWY/Pe1D5AglKqxJ79Prm/4ay3mh
         0Sb/BJk543UX5nLTXCFeDvCY+ZG5DGp/Xqd9exjeqEfIncvzbIxFuc5ni3GIzhw9w9Zh
         RXMA==
X-Forwarded-Encrypted: i=1; AHgh+RprG3Ub+bs4cXy8+t8K6oxKSOlnDgR9AB6ybnN0XrBvDrA5GVkiIV8wSE+/kG2OBDp97RqdqaE=@vger.kernel.org
X-Gm-Message-State: AFuF++mWZFx1EoFiBzkaXrOBVlHXQC9OdLk/nyzw9wuiwUaXTG/kNtxn
	K18vyMu23+OWw5yvKDYM+/zrEDeMD6BE9O8l+/nmU8ofYjwiEQPjCECDVdctSGKs
X-Gm-Gg: AR+sD12fP4JYI61C97UtnYurF34nLsQ7BNeFpSjn6xBRwMzjBxoEkw9Ebjo/GrUh5pU
	/PtqZLPgZLRAjc7+Wd/oAHnBe1EMj6hnkyYLDNdXOxS1IQoqfDQcqZ6pEC18d//pYl/Xaj6ong1
	kcWnlnNvDMA0MAtfqeAIMvmwA6k35zM+Psu4x9IwaA/KcP8OAwhwFfqPhKniJHW502gX9vSjZ15
	gm5B7IszTythbkAYGYsIBwaEKiP8iMpmKxuPIAZw6JWPe9o4iEaa8lp9sIzf4nVdnekCAZ7zDNa
	oxFg0dJbeR0jLtQmdJyPv5TXimm6qOj9HLDZtZ+biBmIS9HNQKYta/Y1GBLGvlHl2bOhGDInNPN
	L8ygFXIc9yAu0cygNmCUxnkTto/unbVe+8U1AyzclaJG/xM9nzc3IF9lILsRmqWjy2/1U3RZNm8
	d1vX9L50hbX6U0AGboqRBU06I1qcx5yLY1sAnH8KR7SqMNLd1JFgrKn13g068+Orq1kU2i8VnW9
	E4CqUYlcuDinHTpu8rLPwS5ZykfGO/ibdGIYJJE6g==
X-Received: by 2002:a17:90a:649:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-3964cbf5921mr1068172a91.14.1787612194864;
        Mon, 24 Aug 2026 15:56:34 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328272232besm1527287eec.21.2026.08.24.15.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:56:34 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: jorge.lopez2@hp.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux@weissschuh.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH 0/2] platform/x86: hp-bioscfg: fix OOB reads and buffer desynchronization in buffer parsers
Date: Tue, 25 Aug 2026 03:56:08 +0500
Message-ID: <20260824225610.18471-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses out-of-bounds reads and buffer accounting issues
in hp-bioscfg's WMI binary buffer parsers (hp_get_integer_from_buffer()
and hp_get_string_from_buffer()):

1. Patch 1 fixes an out-of-bounds read and buffer size desynchronization
   in hp_get_integer_from_buffer() when reading integers from unaligned
   buffer addresses where PTR_ALIGN introduces padding.

2. Patch 2 fixes two heap out-of-bounds reads (passing byte count instead
   of wchar_t count to utf16s_to_utf8s(), and loop bound expansion in the
   escape-counting loop), a 2-byte under-allocation check, and buffer
   pointer/length desynchronization in hp_get_string_from_buffer().

Tested on HP hardware with CONFIG_KASAN=y.

Muhammad Bilal (2):
  platform/x86: hp-bioscfg: fix OOB read in hp_get_integer_from_buffer() on unaligned input
  platform/x86: hp-bioscfg: fix heap OOB read and buffer desync in hp_get_string_from_buffer()

 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 36 +++++++++++---------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.43.0
