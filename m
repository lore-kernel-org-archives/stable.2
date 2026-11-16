Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866904;
	b=bXuRzynYkVJm24rFcK4JAmEUd4rAn77RvM6FZVjSvSZBa1V7wdolC6Eym7wYbr0SjgyT
	 WxsLovWIzSZiV98/zxOqSpeQX197aeMTcxyPMGq22hzgwybF++kOoM615UWCC6jOjIJfO
	 zjCqeWppRjA05ZmKtNkSzdL6jgm8EZAFrAKyh0z2qNKfinbTKEElhBF57b9EHdHVMeA/D
	 Mawl7kyMML2ipGGAAJDKFi1fWQrPclzd3bWbKbVR97VGHAhzyFFzUt4DiJtgYweUzvViP
	 vz0S/G9RNDnqp3e28O23ZnWOwcRQL9PD/1ZKyOcPVMxaImRfRbVQDUxvr3c9DXsAYug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866904;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jCQCdjWXGwSTK6KbBHTCoC610xQNusLZzaXj3lRu9vY=;
	b=pYxIiw0NkUIa06k6QG6JkHp8ydo0dHWUNWP3HU3xxP2ZfifJnUqeXVaZPD2k8U3GjH/k
	 F4va2bgE9lECaP0/NdVXfFKXSoDY4tWb6zuYRjwWTCgrLRTPtvxHbqJbNPPRsJwIIhcZL
	 hY7dZ00ARenG48b9s1DyAm5p2ZGSd9U3zvQerLQtGpLjpXIctyhdsXDEXk2lBqWMO8c6K
	 llN4laH3VoJIXSlsadDDcCLTrfaVdtcd3pIacSrZSulXzAgheMOQrJZHGlU3EourSCH/2
	 H/QPNdtrk7tG7vqcmiyCvCxHzs2emn0urTol43oJXoxSd+4deWsHy6+J6W0z9twZWIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Jj0cwWoT;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ywkyBbYi;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A73606A895
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A73606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Jj0cwWoT;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ywkyBbYi
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYk4S3935624
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=jCQCdjWXGwSTK6KbBHTCoC610x
	QNusLZzaXj3lRu9vY=; b=Jj0cwWoTPJ1LT1nEtYVY+g6wopvZb2ugEOPQhvYuZD
	rZXjEdPYzTBKd0n/Xn2H0QkYSXsJO/OUQU+SG9NXan49oxGdVH3tQCnG/gj7tMz/
	3L6Eh/do8aRZfoMXmalg6p7RAsCNIzgG0FVlNk9wo0DHSKmsyfPVtP/NQI0Ctmpp
	H7raP/Dx74Sy2BfJbdthP9WDn2DDVzGz2lEkkrpAHqIDRLHcIQv62vB8EAxUJd2D
	+55kJzkTDg4LUOlHrKKY/4VyAScWN0dBbcVdYdR2QMXnkXNXe176zsyOFAEbqW6B
	Z9ZV+K15NNLLDng6fzrtofQSHdK/dm0t/zgeBR6EZsNg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059ck745-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:08:22 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495dd0f07eso676755685a.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794866902; x=1795471702; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jCQCdjWXGwSTK6KbBHTCoC610xQNusLZzaXj3lRu9vY=;
        b=ywkyBbYiDRW95M2a1ooFhISBYvF1tXOptyQi7HDLEkFUXXONSwX6hV7R7lTFoz56Uz
         akFYtpT6+6oofBGA4+/eAZOtRk+uFEq8mQ9v35mjU2bZvbqq0KyprgbdXYx/Cx2TA1c+
         STT3MbbzNNJC1/kFeFcCAF5qf9FVlZZXn646vqlzWmogftWIai51xrQs8L7r0RFVhI8T
         1Uc5628GUP09rlftVMCrKqIMEhGzAcolNqb+b2SqPomvYxOEv5LMZb636LH4IgHAU+2Z
         d1vF3xmEp0PYpZgxXwS2EktTfBSiI5u552QYEs8MRmgYZnFKPxhoix1dXY/+wSK4JGvf
         cp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794866902; x=1795471702;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jCQCdjWXGwSTK6KbBHTCoC610xQNusLZzaXj3lRu9vY=;
        b=G2N8jUG1vE9c0hX5EBjjybbr191msHgtIJrlPLLa2alvtdBJ8G4e8xQETQFsTLALzW
         aRrl81lTvD7hJjLl0zWYeSl77ur1Dn6YiGY6gIdYucSnWso2MZ3GqY+pzV5pOsYUqaLJ
         1VaO85GowW7cI4aIrG0BLzOc4UCX1pPePt1Eerg+Y/fbsCrzchLKyvzlSdY88cdWYuX3
         oR5eJzz7IAobQD0NII8jBYNQiA2+jrt10csoJAqQFsYgKqR5X9bZcNslD/BQNr06N+c5
         WQvbpTSGItNwM9jUQIOaFAhfkFIUXAIRtWr5/bx8VGJN0XdILC3CkLR5QXnjDsC2n5hj
         5I/A==
X-Forwarded-Encrypted: i=1; AL+hErG2qHxqb2SpB4r5UWKUdxdPkmcTgDtZ0nirvVfBSt1CWF4VY4d2r0ihTtQJ6hB5NmQeRFTu5gA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I/Y3k0GESxPVDw8g1tabnOtN1xoTOK4WNxO1L8PYyaqeAO6mS
	3kSaABo4CngZecFg0Ih+FEr196cpR847R79WYgKn1A25i7VaRNMKGQGPvfmyvkc/6yMAKtG9AyN
	htVgkd0Q0LaL96nPo35lSJjjCOY5Qg8x44TMjW+VI7aXesBItQ18a6w==
X-Gm-Gg: AYBFou2RugBA+fqM4OK6M+SfJFwB9eqW3LVMoKjSka56RWNepFcJO7N/hy/bGJPnxNn
	yNFNBTm+S8/FSj+wz5MRPdeH9GdJLbJNdY0J2oYi1WTcsgyU9l1oerSkIYPFjDhPfgxJZHXTO9j
	rcT33rH6xXzJ3g/Kf1ZU3C7ABv8ZXjyW6GHiv1r7jl4tJyTNGS7xoqfVjrf2iCgFz7sYx9L5XPI
	O2mKLZCMLQCr+eEa5vikWek2ddehh2RX+kM5AOk2f0PyMUwocrZgi4cUN/ThaUNLp6Mf5iGLQ6n
	bReQaMQwqeE/pCJHufwAtZjF1uH5n9op/vXJdwRr7JG4+gyp9YgizR+JUEQ3kr1Sj4givR5qDjL
	SENU3tWivMh7YbQozAxtz/ADkO+adXbFrRz5bZ3E582V161fwgDu62qEEYda1phMAChwYutXX/y
	HOTt9w4x5DM2vYBm5Fzpr3
X-Received: by 2002:a05:620a:6cc1:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-9494bc57948mr1946978085a.65.1794866901699;
        Mon, 16 Nov 2026 14:08:21 -0800 (PST)
X-Received: by 2002:a05:620a:6cc1:b0:93b:d7a1:ba16 with SMTP id af79cd13be357-9494bc57948mr1946974885a.65.1794866901277;
        Mon, 16 Nov 2026 14:08:21 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c86c946sm951838885a.25.2026.11.16.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:08:20 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 00/10] ecryptfs: remove the remaining struct page usage
Date: Mon, 16 Nov 2026 17:08:06 -0500
Message-Id: <20261116-ecryptfs-folio-v3-0-1aba8e620eda@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAMZ++2oC/3XNQQ6CMBCF4auQrq3pFKToynsYFzCdSg1S0kIjI
 dxdwI3RuPyTN99MLJC3FNgpmZinaIN17RLpLmFYl+2NuNVLMylkDgIyTujHrjeBG9dYx3NFhUA
 kVCZly1HnydjnBl6u7w5DdSfsV2Vd1Db0zo/bxwjr7i8egQtusgwkFKoCnZ7RNcOjsuWe9MBWP
 8oPQR5/BLkIGg+pAZ0pfcQvYZ7nFyBUA7kDAQAA
X-Change-ID: 20261014-ecryptfs-folio-67e80ccec7f3
To: Tyler Hicks <code@tyhicks.com>, Erez Zadok <ezk@cs.sunysb.edu>,
        Phillip Hellewell <phillip@hellewell.homeip.net>,
        Badari Pulavarty <pbadari@us.ibm.com>, Theodore Ts'o <tytso@mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stephan Mueller <smueller@chronox.de>, Adrian Bunk <bunk@stusta.de>,
        Michael Halcrow <mhalcrow@us.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794866899; l=3051;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=e9ns/mhrua12V9cs3nOxOTFGBfzridFhDLFScimnOns=;
 b=iBVxfPIBdPottMuKyPmmAPo79Z1TtTJ2eIEFxn5bup/BvRzKZWhGSUSVKFVGq+hcJWd/M6Hi1
 ABps9rU1r/nDCzVpL6RuvalHXWAsLG0wm+gt9MHin7ZrhDMws2bKUL2
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX2uTPOx2enWzd
 HpSKlYbmDXGJweZI5U5+M96MlLBOthH2D2Hf8PTUdrswx0rbgYJ0VmbYhoCDWXhbcZ6rYGg6OeN
 WkvxbfbYfqlwXRkDilgDq9lktwsFxbvfThRbVqNWMh3QTYiACo5T
X-Authority-Analysis: v=2.4 cv=MsPHeGae c=1 sm=1 tr=0 ts=6afb7ed6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=bC-a23v3AAAA:8 a=yHkjf8DjpYn1_ea-2f8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: JlwWxk_KnthRKt3j-gybysxsbtoFhOWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4OCBTYWx0ZWRfX44vIp0EISuOX
 gP3QUMJCOGjscyml+DGLLfWngyJ684XKlZCfTszHLe3NjriEiEANbKu/nKxcN2QZsDOaaqfrLyt
 x0BYw4Z/ZsJQcXu6uS9PFsF3xAMoEWpifWPYI+IVSjrU6/pIV23GZV79UkZU0ihra/KLem4MsQP
 2G99iVGns4p5hpmLU8gbDU8gUTkJrRovvlWMavj5yf56XLEIBir4Crb59zHEoCUifYxImbrsN3p
 9CLWcD2Kp4HCbrzeMEAuTySozMFxctrJgaUH3e1+eD5DwGqDKnjN8KfY9WtpEcMIgnMXA/QjK0u
 Hqive226jsUg0LcLq70vtg+0ZGkcS72va3p9Z6wwi/KBHlu5wCsAr3ujwWwnvqOf1hSq1bHWXzU
 yFeRD5qd/FH/lUkceOOlb9Dk8mW3fRsjPuk1fSTboHqv6oepQsLjTmyO5xiKu3nPrAXuZ2LVY5W
 e3lZMdfCCs28zRdjE6A==
X-Proofpoint-ORIG-GUID: JlwWxk_KnthRKt3j-gybysxsbtoFhOWi
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=10 clxscore=1015 impostorscore=10
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160088

Convert the page cache side of the encryption path to folios, and use
plain kernel memory for the buffers that were only pages because of the
old interfaces: the ciphertext block, the header buffer from
ecryptfs_get_zeroed_pages(), and the scatterlists built by
virt_to_scatterlist(). Also make a shrinking truncate zero the tail of
the last folio in place, as other filesystems do, instead of copying
from the zero page through the write path. After this, fs/ecryptfs has
no struct page usage left.

Three related fixes come first. ecryptfs_write_lower_page_segment() now
writes from the right offset in the folio, which matters when a truncate
extends a file that is not encrypted. The packet parsers now reject a
zero-length encrypted session key, which used to leave a file set up
with an all-zero key. ecryptfs_write() keeps the folio locked until it
has been written to the lower file.

Ran cleanly with fsx and fsstress on ecryptfs over ext4 in the default,
xattr, and passthrough mount options.

---
Changes in v3:
- Patch 1 (new): Write from the right offset in
  ecryptfs_write_lower_page_segment().
- Patch 8: Skip zeroing the tail when the new size is page-aligned, per
  Sashiko.
- Link to v2: https://patch.msgid.link/20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu

Changes in v2:
- Patch 1 (new): Reject zero-length encrypted session keys in the
  tag 1 and tag 3 packet parsers, per Sashiko.
- Patch 2 (new): Keep the folio locked in ecryptfs_write() until it
  has been written to the lower file, per Sashiko.
- Patch 7: Hold the folio lock while encrypting the zeroed tail and
  mark the folio not uptodate if that fails, per Sashiko.
- Link to v1: https://patch.msgid.link/20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu

---
Tal Zussman (10):
      ecryptfs: write from the right offset in ecryptfs_write_lower_page_segment()
      ecryptfs: reject zero-length encrypted session keys
      ecryptfs: keep the folio locked while ecryptfs_write() writes it out
      ecryptfs: remove struct ecryptfs_page_crypt_context
      ecryptfs: use a folio and a buffer in crypt_extent()
      ecryptfs: use kzalloc() for the header buffer
      ecryptfs: use sg_init_one() instead of virt_to_scatterlist()
      ecryptfs: zero the tail of the last folio in place on truncate
      ecryptfs: rename functions to refer to folios
      ecryptfs: refer to folios in comments and printk strings

 fs/ecryptfs/crypto.c          | 145 ++++++++++++------------------------------
 fs/ecryptfs/ecryptfs_kernel.h |  21 ++----
 fs/ecryptfs/inode.c           |  55 ++++++++++++----
 fs/ecryptfs/keystore.c        | 118 ++++++++--------------------------
 fs/ecryptfs/mmap.c            |  60 +++++++++--------
 fs/ecryptfs/read_write.c      |  54 ++++++++--------
 6 files changed, 169 insertions(+), 284 deletions(-)
---
base-commit: 8f6626bd6594a78f454d02b27b74a580c890cab9
change-id: 20261014-ecryptfs-folio-67e80ccec7f3

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

