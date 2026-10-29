Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356007;
	b=zeTl5hHdBkUanMykh2fMu9yY+yB11veTcVNU/5LOh+r/3Il1VgIFsa58NQDYe2fFNCqp
	 F35CH12jcFlp5PUfIAi1cMJs4ICQnOukylHqHvK+UQeuaXCW+RPZ9FrelFTVrwMYuu24P
	 /LEXMrrvhS/Tf9YasmsQyltMjI34SxuAFITr4EDIAn78ZeMIxVSoU8QjCQf8zO7gYs8Nd
	 Th+YWM2Jl3YxHsoiXJcwAM9jj4ebaj9rsqUbzHpkFfd1vknL22lzcZ74PM11Xcmftehyj
	 zLOuH1zhJJJqgqIY8Bd8MGMikGLtYDuOdIVu1XCi5mhyshJkW/23pfxkA38tSPVfqrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Proofpoint-Reinject:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=59Ozb7vPHHK8a62sFDWgZOfWdnPHAJYeNCW/LcPyMCk=;
	b=dOXUW8fgoINGGz6zYqsvVmxVWn4nkZhJbGtH8uvmAtVoTMmBwiE9OTK4YS2Bixckeo7l
	 aspMMczQj24KXlVjT+cOKG76YqTJ2pz4VW3q7QdWstkzLFFRK59SJoIQA/+6nGdgbvwem
	 rAITf16xFeLcrkG0PTUEab/+UvICHwBM0PoXZFWKe/o/apwkJSRMCsZDpmzts9ZJUmz71
	 LexzE9W+Z83k5rNDio6YxqMWR3VunNE4EaCZUafJLtFP0rj/ZAxZXWwh0fWBj/ZszVhgC
	 A7rj0bL6SVJfbWqiUE6FXvnzx84tLYqBxUMtYFoGvq3xzWCSx1z+x76+Drd7Mb8zsNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nhc+FC4v;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fg1w8IDQ;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DC606A320
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 716DC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nhc+FC4v;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=fg1w8IDQ
Received: from pps.filterd (m0167067.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UALTSW916889
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 06:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=59Ozb7vPHHK8a62sFDWgZOfWdn
	PHAJYeNCW/LcPyMCk=; b=nhc+FC4vA/6tt68a/uzpF45cTcNXjM9fomuaWnrk24
	GABlqMOB9FLLM0zL5xBDE+JeCUGsR4Q45Fh+p9fwzb8tvmKPZSH2gHwxqVrUfiHB
	mB3q668KCodAp2WUS/FTAsEvwy1iiQpiW3Ud0EcPvjYzvT6k/sr55xc1pRoNVVZy
	4K532A7jwMz1QmmStaCC3S7eleunbLZy5Z+rEu/HF7AsxJQv1W7lALu/o/yWO3Sm
	U+ah4zasDjPtVlc9eHERw190gxz9xQBQMcgZzrI69th0Usr1Zfep0z58g4R3PwlI
	wM5TdxmR80vWQ43A3iNpAEi6VX3BxlsoBSjWCHXF7JlA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hm64518j3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 10:51:45 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb71b1443so463889785a.2
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793285504; x=1793890304; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=59Ozb7vPHHK8a62sFDWgZOfWdnPHAJYeNCW/LcPyMCk=;
        b=fg1w8IDQ9+SJUbO83Mg7uf4Qt6w2CMkC+YvBcfdjroqkcUsWkeNGhn147q/okC4yiC
         oWZiPAO2E/q8H/k1aEkCegh2KEU8z3tMUGln1yV+O5Aj8HlEZCB91ln+MCb84R+IlANU
         b1yCc4Z0sJ1abN8i77hqcHAhZEB9Hw40eWRoAdD7I/HcIjzxQbMTjz6iMcF7gWeA+wQL
         SfUjQqE5qfBW4L1EPsaGd4RY1+9di4hGM/nbg/AyBHEOijTlUTv7P/f2lYZwTHMHRQ2Q
         cII1Rv04z5DsB6vAQ9ZjQRy2l/x83ljUs41MXbm9ab6iB5RZ0XxMDKqqSihwBfrBDKfB
         /PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285504; x=1793890304;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=59Ozb7vPHHK8a62sFDWgZOfWdnPHAJYeNCW/LcPyMCk=;
        b=UaV8Zl0uEBkxX/GGgMRbgsYUqd8FBVWBmc4GMKEtXgZ+mOD8D04VS4/mEQOv8jaQHV
         f+L1QXcBcm2eHIGtZbH7iVSIPESNLA+lT82ikFpxF6P/qzsBAte7W9lypfelYyak/NBP
         Pgf2VO9z1+NR6F5huQUrZV1TLPR/kuhl+HFp1musSXm/B8CWqIY1cSf3FdxCYEGiLGpU
         BMYQkL5Ii+ONhLvMMV0Ehy7LBXQx/9ej11zzYnA+afeuLgUT6XgcyuwT7XZEkqYSvZg/
         3A/KPyX964qPwLHqnu4a6i8rn9QGUiFlO/1Whs1bv/ABa07eMaJujd5pklByZNgc41km
         JwKw==
X-Forwarded-Encrypted: i=1; AKwUvBzwmKdPZGp/1GMJEovYUNi7rcieYafV0UwGKEm4CHpzN66Sn9TAeJf+aEmF+f6Za9LSLavLjZ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIn7e6LzJPZJLjTR5hyv+k5dLrkrMHHehQe4+o2oHsJm8ELACcQ
	tpR3rKNRQJTS+IztoM6lYp19YJUecNDJUkY29ag6+bY3uZkaE954pPviBPyEzVEEM84Rk+XQ8nz
	UI1ayNRtcQeCER9SKUwXZo3v/6IDFpWcERtk+OI1V4y/3N8XY/Ruqnw==
X-Gm-Gg: AYBFou372blPhFWyIdR+Xkv5TUk7NAdLXSEzgfA0ct+7sMBSdUPxwI4ox5B36PmWLvz
	epoGyZcIv0Pm0ELDwxbsIWIBXofehUKBBU64FeSVbTbsQUZXeEi8voJ4SZ/++eGgApTkaEsRTag
	MZZtk6GU5Wsebl/mSLieDAA0qXwYNpLsj5OR/PARWJqSWwTWDiGp7fI7EzLXXB/Syv7JIzsz8xh
	X1zOA52YfUJlglYEHLXbiyLZXkt/nFj+UreAQRcKx+bA0r3QK5KIHTLORG3TeqyB0BeNAj4Qp7/
	wKlP7m32RTPUfE08nTFjGPICbWCRfpG9BnQEIZIJxM21z5ehdrdx/fsrND6C9WWAg6MwrIyGH3S
	tlRFnzxTYiH8zIBbcLAh8nS2iAeEry9RGNcwS8pnChLvnN78eUm72WEF/UBewPlJEaB4FjuFOk9
	Q/WqtTOwCnTlU/69A=
X-Received: by 2002:a05:620a:4107:b0:93e:f0b9:505a with SMTP id af79cd13be357-94408ceb986mr911547485a.58.1793285504531;
        Thu, 29 Oct 2026 07:51:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4107:b0:93e:f0b9:505a with SMTP id af79cd13be357-94408ceb986mr911542785a.58.1793285504013;
        Thu, 29 Oct 2026 07:51:44 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm78153515e9.5.2026.10.29.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:51:43 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/9] ecryptfs: remove the remaining struct page usage
Date: Thu, 29 Oct 2026 10:51:21 -0400
Message-Id: <20261029-ecryptfs-folio-v2-0-dc53f1d47d9c@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAGld42oC/3WNQQ6CMBBFr0JmbU2nECCuvIdhAcNUxiAlLTQSw
 t0FXLt8yfvvrxDYCwe4JSt4jhLEDTuYSwLU1cOTlbQ7g9EmR42ZYvLLONmgrOvFqbzgUhMxFTa
 FfTR6tvI5g4/qx2FuXkzTUTmMTsLk/HI+Rjy8v/GISiubZWiwLBps0zu5fn43Ul+5naHatu0LL
 gdYgsEAAAA=
X-Change-ID: 20261014-ecryptfs-folio-67e80ccec7f3
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793285500; l=2528;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=MHQHbr1BCeZw176BeIq+ezbLBqffStXmrVqOaMJ/nQQ=;
 b=APpNhk/GxBuPNTA1HtPJwEIP5w1L3UgpougRu8JilBee/ZtfG3Q/Dj7aPnByh50bWA4aRaP+K
 lDThVxwrrvIB656mxpXMe5TqSGeoZLqDZa7kmu+umjOJ9g6i/Fk6Fgw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11949
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=10 phishscore=0 lowpriorityscore=10
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290058
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZtMrvRD-nqdJJujiTEi0706Dz6f2GhCf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX+GfOuVnDLbQ3
 T6M2tfIq0NN9tkqXT/A39469cQMHGa+ImkGzSmNKAytzpe7qkkcRzzI50aZJgVdmIYpEJAqIj8D
 pfyPDP9tUWO5fEEMAiHeyX4imj1fDhWMasj1OlYjBJtjFtemP6ChAjIybw0r1tIoeBnr7Xsr0IV
 2aq6yLp+n8xWUwtAojO1dh/GwDXxSmKVK3ze2Why1Ze1UR/b4g1ubCjfrsNzRG6Dffjea5d1jN+
 W+J3+m5O3v7E68DxSaAtPPSBGO0nBEteNSlr4rAmriS9Zvseabcn7rfxTzbTIl5QhsmzB8EPPEt
 O66DAPlUhhD3oMt1kBWB9P3VPLgG2DJB8fE734Smtm4lXQWbfY/l8ER7ZbuRuTDMudq4JqiZJvr
 8EaC2d8gXJdL1WjiogpqDYh9D1zIkVz8dbyDxyPI0NoHx6hD6J08JoDL/B+iJFyOmuxLNu2LCQS
 T7D2wAzNmWpa+wTL+Ww==
X-Proofpoint-ORIG-GUID: nY-WXbjHKvjcNljzrRndZ3E-v-5y4NCm
X-Authority-Analysis: v=2.4 cv=BKEmP1QG c=1 sm=1 tr=0 ts=6ae470e5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=5seVXgKEpYMQFUWKuG8B:22
 a=bC-a23v3AAAA:8 a=yHkjf8DjpYn1_ea-2f8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0MSBTYWx0ZWRfX/r7rzNI+NpYM
 Z1MdOviDpKCmT1R3bj2Q/wnO4YWJRN0suSBjC/NjNuahqE1X0V4255CW4G2aiaVlmslER3FUCXZ
 6atIeSCOOb0wHB/C0InFMsfmz5sLY/nfkUs3Ec4oSpK+1VMzZD7l
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11950
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=10 suspectscore=0
 bulkscore=10 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.22.0-2610190000
 definitions=main-2610300041

Convert the page cache side of the encryption path to folios, and use
plain kernel memory for the buffers that were only pages because of the
old interfaces: the ciphertext block, the header buffer from
ecryptfs_get_zeroed_pages(), and the scatterlists built by
virt_to_scatterlist(). Also make a shrinking truncate zero the tail of
the last folio in place, as other filesystems do, instead of copying
from the zero page through the write path. After this, fs/ecryptfs has
no struct page usage left.

Two related fixes are included: the packet parsers now reject a
zero-length encrypted session key, which used to leave a file set up
with an all-zero key, and ecryptfs_write() keeps the folio locked until
it has been written to the lower file.

Ran cleanly with fsx and fsstress on ecryptfs over ext4 in the default,
xattr, and passthrough mount options.

---
Changes in v2:
- Patch 1 (new): Reject zero-length encrypted session keys in the
  tag 1 and tag 3 packet parsers, per Sashiko.
- Patch 2 (new): Keep the folio locked in ecryptfs_write() until it
  has been written to the lower file, per Sashiko.
- Patch 7: Hold the folio lock while encrypting the zeroed tail and
  mark the folio not uptodate if that fails, per Sashiko.
- Link to v1: https://patch.msgid.link/20261014-ecryptfs-folio-v1-0-f4412187b1d3@columbia.edu

---
Tal Zussman (9):
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
 fs/ecryptfs/inode.c           |  51 +++++++++++----
 fs/ecryptfs/keystore.c        | 118 ++++++++--------------------------
 fs/ecryptfs/mmap.c            |  60 +++++++++--------
 fs/ecryptfs/read_write.c      |  52 +++++++--------
 6 files changed, 164 insertions(+), 283 deletions(-)
---
base-commit: 8f6626bd6594a78f454d02b27b74a580c890cab9
change-id: 20261014-ecryptfs-folio-67e80ccec7f3

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

