Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711856;
	b=xCstNSkcxTLryPi2QRTIP/kr3ME78tNOji3omrwgU28UiLmA69NJ50hGHfRltTE59iv2
	 OTGIav6jxa+ztyDa+6Ye7fbWYsZsARNnCM1kd3yv667ssAS6dILA3r75fzYnVxrb2mdin
	 sbAoRqeS5oNtylsP4u3JSEWVe9HBfuXQ1YZc3q1b4Tetu/k/R8aS+Pl1KCGEZHrofHb1i
	 PnbBI6f9lRmyiM8EUxJufzWN6lqE93tbMQtivs2D5L6fY5kOsEIrapMNHSTjisZJeW4FS
	 w4ERBVv34iZCKFQN6nNSvM6WSacJncPtTd3r/7mMJgP6mB/1mlXg4cwzO2E4SBn6QnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711856;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=krGMqJXjl1D9Mmra3Z5byR4JKzxKLC6rxWf5tOUwhzY=;
	b=R5bpOp6E4VdNXuZo0RIOtIl4sM3oU6ZeNy9WNmrHfq8vAoaVH6NkbFMpYhPNZwkWXAd6
	 BY+mwwEAjGxAbXziPYyhxml3uDB0PiwVgiolGT8IwWGF5EikZ7DtD6Pb2kWKTfPN8RTYT
	 DbhtaRNkMbv7QqT5R2+Lz36/TZVFs37gsCcganNI4A60WQo+zYEqhX+PdiBy9gUCIsi0i
	 iQx5OdQAq9bKoiUx040yhR5owaRPqE8kUFAgtV3p0fJfrYtdUSOaQn44+ik9cabVDeiDn
	 8nL851UlQSeGskcUH02lT/vOIDqqPP1y7gvZ35K21D8voxPsWdsD1UoYyjZhowS1aPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b="lfXu/H9z";
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=XOuF3Hzx;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1218606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1218606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=lfXu/H9z;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=XOuF3Hzx
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A38SGmp4083639
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 08:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=krGMqJXjl1D9Mmra3Z5byR4JKz
	xKLC6rxWf5tOUwhzY=; b=lfXu/H9zjyqkaIVUU0VXqVi/rKt7bWk2lXNuNWgHMR
	kfq+h7nTeHbUwoENtYJNJJ8Ekr8mogJhLCDbw725H72ZoEEsyNwcE3sxxZZWirO9
	O1hB93DZYhleGmo9Nywq/U6R4tNmPU0qtSB9oit13Vbj+XPvNHlsNzaC/ohvTwTT
	ot7W9OSfnjWiXufejJz+V7foDMoh0FglmCvGNh2U/rfCkI43CCecXJEVaGV3yZN0
	j4dQ5KOu+jkXYrieVPnr2sZjDHBpQrDq/XwUqtaU1qy48wx9FLlZ6gBWDZnkxz8N
	UYy+ar8N0+msWaUEVjmBpBo3M8zYxbpOOINovT5cvQLA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hqawfseaj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 08:17:34 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f32050e72so606497385a.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793711854; x=1794316654; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=krGMqJXjl1D9Mmra3Z5byR4JKzxKLC6rxWf5tOUwhzY=;
        b=XOuF3HzxvftrvdQK+rv00mbnHTzwkDPk7OaUuk83XXrwcukZpRy/0uO0FWJHBQlypy
         CcZeNM0zZOKZFbpcSE1lv5K8j3+7gJiagaBJqXBzo8hW3GMektkVllwQXkUerSn9rdQZ
         Ihl6fwZMZpqRcAY7ktPYw2+JZRyJsgzHRAwpqX4LR0ybzjCB9pTBptcUtdPX+3NGL26o
         +wjTWT9cB0RPNzKwvnNSettt95jvsnSZftRpTpUygSBVnNzmGW+oFa/1VWMqjid5oy2J
         hOTcXoOORwXDT+SjCJw6TR/QDoolt4fvglx+mEzLSKlu6vqhvEDc2IJqrOIcgqiQRWlt
         CIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711854; x=1794316654;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=krGMqJXjl1D9Mmra3Z5byR4JKzxKLC6rxWf5tOUwhzY=;
        b=cTsd2b1V65m5r7ZWBmlH+eS3/0V8zIKxRwJgBczhcBk5U1gmxdftnA3gDHJvOQ5WcW
         7a9oCSqCXjQd1G/n9YgsxXuu4Et+2eXR4ntACJnZ3LNJO8Hc9lAYgmW/OHElD24RkUKs
         3Sd1M0A6lijD4aPKmlfAYFZ5AB+jSOK7atFEg6vc8tuQy5rtb6uzw1wzfP7Ne6hqXtBc
         iSAlAtV4BjEQpihmV620fr23I2IxGDOWID/iqC7iE1dMtPBXFoXkyUDVD2aylW7a0GCV
         eRd35gKWvHzCsj5FEtyrqGf6rBdN5zupKWTCLGjasx5cSJaOD8ouUEls0m0XkYQHJCuk
         F3qA==
X-Forwarded-Encrypted: i=1; AKwUvBzgHc18W4JN+3Jzv4+z9KZ9oFFcIX0l35cq8XoscSZgICyqThczoeI/N/MK6oMjxrv5XNhHmmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nBlNrrfczFJ0I58MRBlPAIaBaf8vLOXybvGcADQHvMAZZoAkc
	ztrjWRcBI9SPyZJko5UgAGYlb4lr+NhnSCOkRsuA9yoGna6D9+jJnw7vQFFtB6uSrz0Wh/sF95X
	MqJdk/Igz5hSSWGZh5xQEUFiFz87NRN+KOkJ/eDSuKWSdru9yM1yRWA==
X-Gm-Gg: AYBFou1SI+o1TEhowEs8rdzrGRqycysND5EiejJwd+XO0oZ8RbtykSQebfvwebGP7tZ
	iyT3X5N7a3F7VAc3FaRkNMqy4tfAFIYq1NzvT9uzb0htKzlnYUBlAftFga9tbJM1cSANHC1SAHx
	SX4x56Soza2QftCCooZP6FzNseWO/CF0/mMtlVF2sv2gezNw6ISLnJyE0N/GR5AG+uaG7J4b3n8
	c7+eX7hGpqW7l29UKUDCAEGk2hqyKSP05aidokOGq8duCFWBpmVaUM5D5/P7UKO1Zzod24joxHF
	3uZOS9rlfaFV/i0IvdclRZD6LAyQnaipnIrBVlSUyLc79VvPEZ0c+bZh+pzeYTBCvtFZ8ScB7Mr
	K+4kUAYVxvQxF8anK5RcLV9VREvf51tUQvneROphuQjXqbY+Jl50GetVnlBE=
X-Received: by 2002:a05:620a:2989:b0:939:de48:e41f with SMTP id af79cd13be357-9442167723amr2271885885a.31.1793711853683;
        Tue, 03 Nov 2026 05:17:33 -0800 (PST)
X-Received: by 2002:a05:620a:2989:b0:939:de48:e41f with SMTP id af79cd13be357-9442167723amr2271879085a.31.1793711852988;
        Tue, 03 Nov 2026 05:17:32 -0800 (PST)
Received: from [127.0.1.1] ([37.142.147.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa5781c9sm62076885e9.8.2026.11.03.05.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:17:31 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 00/16] squashfs: convert the read paths to folios
Date: Tue, 03 Nov 2026 08:16:58 -0500
Message-Id: <20261103-squashfs-folio-v1-0-7b0fd4d20882@columbia.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMre6WoC/yXMwQ5FMBBA0V+RWWvSaYLwK2JBTRkRpYNIxL+/e
 pZnce8NQoFJoEpuCHSysF8iME3Aju0ykOI+Gow2OWo0SrajldGJcn5mrzLUZWaxdKbIIUZrIMf
 Xf1g3n+XoJrL7e4Hn+QFDG1KIcgAAAA==
X-Change-ID: 20261012-squashfs-folio-51095c19f276
To: Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793711849; l=3053;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Lq3LJENrUjegDb71lgLDYM552fD4afWLvC+uQdiwjaw=;
 b=6db4qgrCklzf7CZv25CyimYW5qpwTC8nJLH7rrUMnGK7GHCQ7Shz2WHhCHeYQ0DFW8U6SS6sr
 y1zLiaxlxo/BmekXXszUn/OjZlV2eL2NrJaWUC0Sw3wg4QiW8LOxdzg
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: dbf9rjrxp4hxgT0E4X0oCRhYqrozi-81
X-Authority-Analysis: v=2.4 cv=DsXDa2/+ c=1 sm=1 tr=0 ts=6ae9deee cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6RgaMXXTExC6Yw++yBnrug==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=LSP6vmwHhFFJrJolKBEA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfXyE/PuCxnhdxX
 yxHM0ZmaLZr5ZdfGD8rslzABzWKnrmCjZqofQLNpgwiSJ7x30t3+w2rdvD5EH7W5qqfZijJMMSa
 UCFoqBM+4GRTuGywV+/NEwqYoC4W4qynH730gN043ucMJAdBDgBE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX+WM0yLQOkvIB
 LJgI0PIc3o+2JPnzVVxAiX//tDIWxdgdf+juwiEiL9qHITKFgVzfDMx0RaNwyJXxaeE73WyuKp/
 xPHDWM8PnuDRBgQGmG/eKsqXsE1CUbO6aOzZr/QLtRjwvCmAeFDSbXLnGz0w3ul03uxHnrsJWN4
 rhwYyQS25YpgxR0zVSisQBLDvd2UpoVpwivtJLQPymedOP/opAF4w80A+HPvd6V+7AcDgsLBUSn
 sVSfGANaq/5Y0yjZULdgCzrwFSD1jwIK6o/dyG241t+sGs3EqcsosJAGcrBOVlWQkAEEizqFhPR
 w9dfzEqCNj33iVCfzhwZPLn7qwZgKoSjXBJux2dv+VCK6PQX4GItGvvs6KTgJk0fwHWOQQo/qZT
 iDBM04dH3WXSVM0cq8WwOMVJwP3fs0HbPaUYM+IMGP9WxDoP+9QMFDVLheZrZvymw3EJxxOGkBT
 GVMbn8lgEejzUbTC7BA==
X-Proofpoint-GUID: dbf9rjrxp4hxgT0E4X0oCRhYqrozi-81
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=10 lowpriorityscore=10 impostorscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030052

Convert squashfs's read paths to folios.

Patches 1-4 fix bugs found along the way. Patch 1 fixes a hang reading
past 8 TiB of a file through squashfs_copy_cache(). Patch 2 stops
readahead from reading an extra block when the window is already block
aligned. Patches 3 and 4 fix a locked page leak and a kmap leak on error
paths.

Patches 5-9 add a folio based page actor, convert the two users to it,
and remove the page based one. This removes some of the last callers
of grab_cache_page_nowait() and readahead_batch_length(), and a few
hidden compound_head() calls per folio.

Patches 10-13 make the actor, the tail zeroing, the readpage_block
lookups, and the cache copy step by folio size instead of PAGE_SIZE.
squashfs only uses order-0 folios, so nothing changes yet. This is a
step towards enabling large folios.

Patches 14 and 15 are small cleanups on the way.

Patch 16 fills the compressed data bio with folios. This removes one of
the last callers of find_get_page().

Tested in a KVM guest with KASAN, lockdep and kmemleak, with both
CONFIG_SQUASHFS_FILE_CACHE and CONFIG_SQUASHFS_FILE_DIRECT, by mounting
images built with every compressor at 4K, 128K and 1M block sizes and
checking the data through readahead, read_folio, mmap and concurrent
readers, with no failures or warnings. Each pre-existing bug was
reproduced on the base kernel and fixed with the series.

---
Tal Zussman (16):
      squashfs: don't truncate page cache indices in squashfs_copy_cache()
      squashfs: don't read an extra block when expanding readahead
      squashfs: release the grabbed pages if allocating the page actor fails
      squashfs: unmap the current page when a readahead fragment copy fails
      squashfs: add a folio based page actor
      squashfs: convert squashfs_readpage_block() to folios
      squashfs: convert squashfs_readahead() to folios
      squashfs: remove the page based page actor
      squashfs: give the folio page actor helpers their old names back
      squashfs: walk folios by offset in the page actor
      squashfs: zero the tail of the last folio up to folio_size()
      squashfs: step squashfs_readpage_block() lookups by folio
      squashfs: copy cache entries by folio size
      squashfs: use folio_pos() and squashfs_block_bytes() in squashfs_read_folio()
      squashfs: use folio_end_read() for cached folios in squashfs_bio_read_cached()
      squashfs: use folios to fill the bio in squashfs_bio_read()

 fs/squashfs/block.c          |  52 +++++------
 fs/squashfs/file.c           | 203 ++++++++++++++++++++++---------------------
 fs/squashfs/file_direct.c    | 104 +++++++++++-----------
 fs/squashfs/page_actor.c     |  67 ++++++++------
 fs/squashfs/page_actor.h     |  34 ++++++--
 fs/squashfs/squashfs_fs_sb.h |  24 +++++
 6 files changed, 271 insertions(+), 213 deletions(-)
---
base-commit: 4fab3abf085638e7fd2ebabf0aab8aa299486207
change-id: 20261012-squashfs-folio-51095c19f276

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

