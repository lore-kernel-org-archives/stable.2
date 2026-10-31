Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468762;
	b=r6WmSr8b76Spki/ky5cw4SxkXdGU9pOkX/yv1Xcj6q0UVoWLMbd69dbFU8kqCkwUeUJ0
	 M8KYmPv65e9cpl5YKeIZnS3+HuPLK07L5NoDiKweECjJEjP4yghA9ESpO9j5N3P+e+8ER
	 Dk5ZfDkgNyQoBLaV0HbvRS21g3ZW9tZhzLbnvM2YxwhASbqAat5cdfqqhzjCAPXpWk1i0
	 Qktnhflad8kqDnHgYZYWkPGobUxonWQ6uR3ae+rV1GzAS76DgHNSgHxYI+jQeEYtBjwmU
	 UYUsLNeFyuSxQlXPmj6bcDXy6FCPpPYNFdm3hT22ZqenScbsvCDV7m/OuThhKCdOFlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468762;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
	b=2yt5QlTcXJzAonMXP0Ar1uOUXcxJsWYV/wc3AsaIOVr4vWzbh86wffy0fulXS9DDJL5W
	 k/LrFI+y2UGwSuZXSelWxMmHu58qHdHBqBwE4dm+rtHyKQUFrypfLWnDW9QLDWuEVOLki
	 nWoYOhi258m2CQcFRUww0Ua+yQk5OUEBSjMuch8/g51bHkarYf66/m53WXDrc3hEaCsfH
	 9aukyCCvp68Kfzud0woj4NNOvunaabDgsgeTA7mNE6Pjuj6aMfgvk4910KcdlRwtdJVaF
	 XubDQwgXePmG6D2H+rzT+uWCZSSAI+cXSz65NSrQBCK7dgPoL7bIGSGl1foCBQNpVSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="neP/A2aO";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E660A2606
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 17:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB9E660A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=neP/A2aO
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDkCio636993
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=12TO2e0T31cSdEte/htfI+5i3s
	mqp4TVqWraSxvTy3w=; b=jrv2nOZ1hp7gZbhO1vM3/PcfFfO2Eo+JrSCQRcC1ob
	JZIOAFdqM7Cv70L7PuIETHnhd9trPMvIE4Vhr5Ze645lh6+3Z3Yyu4d6HgjnPR+W
	LnQeSKOap9tnbXCFr2Yu+24s9nG4SHxLCy42p6uCdErv6i+HSk+zX7/YTMo7Mmyo
	X56d+LUijffqg2f4G3pQC6yxJs/PWK5DGOYbNI1t2gXcFbRO6bSo1OdlXPsvhW1J
	dRz2RdOGf5rWwSJFVdPkSwT6YDcnZiNKaiOWQrdff+vERJPAujUGw0u8QERN1//v
	tFTTHhwz6oVCE1EidtJ61Jgic9T/tAcuIp2psuzp8EXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hnc7ajfjr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:45:54 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f33438950so341335185a.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468754; x=1794073554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=neP/A2aOSquMz2IRM3GwjWt3KSLmQ+sHBLc0gTN024tS1j2Ga1TlfzM0rbhUpalhBb
         MaMW0UySxvH6gCKTLWrXP1KvoUMJMyxZq6Kh87F6QViiC8q1HcJrGWj491QxL2ztzQid
         xYUcuWjDr6H5ykt/DYN3+8zpB3VcZ9uhk/KMyB3bH58mz9r3g4a7L1if8mbhw1ERRZs7
         29JUjpUrRNh9L/MmkOIbrleXFGUhDt5/NDUouq/1mRCJcYqL+EtlH0zqjLJ1UYSvL76p
         UM3mdFlMF1wfPmxDpHYtD3dXpRphcm0GeIwJ1geGp1JFt/9ftzdUPzhDxbSemzHyklBe
         PK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468754; x=1794073554;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=YlljPFGp2wssyGGDTnzTsGB/3Q7NQQDOVB/ItFx3KCoLKzusiyt7W1XTdoHVMTJOyh
         XBMYDW6VnyMKiA5+fVEvKiU80JejOeADLTCOfr6xC5GnmonYHeCV38/fncii5v042YzP
         oweEsEnYAvFSpil+XNPz2f/Y1IsOF/TVUuEeiICtP41hyXG9KNDf3CeW19hDy7Ghrl8h
         qw5wVpGCRoyg/u0pYMnLRsRWWDTJeTz6ILxXN3n4h0AKgG8tX0VeXZ01UAlLEyc3prYj
         IWHlOdCL8q/5geSCRTR9OtnfmW+2ASA7bfnRJ+GCCFGdaj+ANJQR5Cy7pWJEyPNd5xAO
         t7LA==
X-Forwarded-Encrypted: i=1; AKwUvBzMfU7oFR5hGGVjYe6f3ysKtNHqjORfwxkYzf/lE9LIDNLP+AoGb2iRWhIfqKjTy5CNwZ3FNTo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1TgpD8nhtxwZNjYUyB+dcRJ151hag2IQ/gc/xqA+QoaxBbIcP
	fCtXUzTd7XuAUI3nECTlJ5yLnNBsYr8xVFCl5OgAwPQCHlY/vxNx2D8L+q04iKAIjwm3JkpNC9c
	wt7c8kkDElylMg41ultAyjBC8dx22owILZKbuCVkTtAU2/cviyCb6HQ==
X-Gm-Gg: AYBFou3p2CmuT0MDgg2SaA1BLc905QNLXCaZWH6iE+vhSfI/M6qzwYQee13HR8GDYef
	U2PGBySlAfCTXe5OeMIgMYuLSBHi0qqLKjMswkFCmrYZ6WUjkVyELaybpbM7OF5S0D7auh/OHt1
	6R9TeHsPTmo4tVu1mJLNj3d7wyzSwgmeSzG/f0m8D/LxPxuhkpEQBLNz6IB8EFMrPDLpRKYZ662
	f7Load4ymelLqjhx7LB48gCwjHbQbWF0yVBvuyQ/UVInUrsJ3t5dR23rW55tPPO+Nr9DiSib4w4
	3oXraV1UOlJtoBDxTJMI/cTMiXJEFHuenSliwCamJVWXf49VDeTudfzixQaNmqNmdD4TpEIiCjP
	jZPDvtd9oC5N+CjM7N4/HAqRJebNcavbiG4JAkrTN7QjRhIVtgo/A+AnmGQ==
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882365685a.65.1793468753917;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882361285a.65.1793468753266;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] vhost-vdpa: fix a pin leak and unpin mappings by range
Date: Sat, 31 Oct 2026 13:45:33 -0400
Message-Id: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAD0p5moC/yXMTQ5AMBBA4avIrE3SSvxeRSyKwVhU06GRiLsrl
 t/ivQuEPJNAk1zgKbDwZiN0msCwGDsT8hgNmcoKrXSOYdlkxzA6g4d1bLGoiMoqN0rXBmLmPE1
 8fsu2+y1Hv9Kwvx+47wdX36AmdAAAAA==
X-Change-ID: 20261015-vhost-vdpa-unpin-68ee785a019a
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=yEsTLW5bz4gADvidYrxq5nthN1/BGAv4JgsFze3VSmg=;
 b=jeyY9hiphQ8blprG87I1oONkrIN8Q7ZL/IGjRLJbSRY/hU0x0AZTh7Gso9PmhW412uIWzzlh+
 JxQxyJSbDs9CNUNDmGS7lxZEUsybN2nVwItY57qixt33KLSfa4cYQmD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: _PefDoWhnqLv3oDyO2VZZk1_OpH76G7E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfXxr1Q0gmakr3x
 fhCsQkgFAJLeHmLKqP3OKJzxptiK1nx6C3lUb+dzNDfoOl81ay7G+x9laYk4xRJm6ghYZykwq+r
 pyIRMpv8/1e1DJLl9G/z3zKsOb9DJiREgxupWXDmsoei5m0i5aUo
X-Proofpoint-GUID: _PefDoWhnqLv3oDyO2VZZk1_OpH76G7E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX641qpn8Gr6cj
 IFDBlWCOL4NJ9pqoZwVUl6Riujfx9SjhJeIPQtqmRmlKDSXpB36SYah49Br2KV5WV6Xgz2NxKW3
 TB+TbDG+N4/h7z9QfNBmy/xVmc1E0/mTBPZXn/ivgNtFAPhs4HXwURnM6q7EB8LDaw5bXaaJXeC
 coMHs28gmmqcrSfdUHlpYaJXW6qeBncMfN2J1rdaKYrZJ6pY/QoylzbsZUEo4f4DcLBylhp5405
 Qrvb0ZsVKwM/m68p7YDwaxqbqH6WjwPn4dKk6rItBGdrBQmX3XNlrnjtLVf0BEx+vWXFu+Wqo09
 BIz20oDR/g7RlSUj3T0rMm3vn1ae9+94xh0lccWqojF1gts0lg20Av/umemuAfJ9ZpVIOt3Agcv
 8sW30kvaWDPV+AMX/OxApACTsOSwtorfYOhe+xfAPO6JqXBb9Ccf4ECT7c4xrAm0oFCWrVdyIg9
 eEyYhoE/fMeBCarA7/g==
X-Authority-Analysis: v=2.4 cv=St8Fe/O0 c=1 sm=1 tr=0 ts=6ae62952 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=mS1D9im87lyf6bhA-bcA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 malwarescore=0 bulkscore=10 priorityscore=1501
 impostorscore=10 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310070

While testing the second patch I ran into a pinned page leak in the
vhost_vdpa_pa_map() error path. The first patch fixes that and is
tagged for stable.

The second patch unpins each IOTLB mapping as a range with
unpin_user_page_range_dirty_lock(), which marks each folio dirty once
and drops its pins in one go, instead of a set_page_dirty_lock() and
unpin_user_page() per page. It removes the last use of
set_page_dirty_lock() in vhost.

---
Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      vhost-vdpa: unpin mappings by range

 drivers/vhost/vdpa.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)
---
base-commit: c69023b5e16e5ffe9368603dca76d85bd544ee57
change-id: 20261015-vhost-vdpa-unpin-68ee785a019a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

