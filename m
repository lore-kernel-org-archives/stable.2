Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842236;
	b=zh6ZEctMzKKBEmB8zfW+ziPcYhSjzv+rmx2c1E9ITkNoFPQrxysvx0QMAFB1fwWjrWyC
	 mzJ13FJqDTd+WJvtfqgQxmvDffkEhYWalg2vVDYuVsv2sleT3mh0GoxfcM13DhtZRYfip
	 +cnYU8/u+qaDTiMJt08k7p/5dWJuj5IuTFJfa9vj4rYQalk+NrF7tsbnLYNd0iCYtQ9AP
	 GEIhBwxdkibyldCK7Pw5Z0/6M73+Zp5lx2XQ5e0KKIg6MmIuODgMG33McdPe+hyYiIq7B
	 xzuU/RKeqsVDZckybyllzRnpjDynnOLlT1ws0RBQT6MXYNh5o2ZyapgIG9q/aLSpWZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842236;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version;
	bh=hV5sCbDd0ZFxTornQGVjkDTm2qomq+v0V1DGbkJbuFs=;
	b=HE4NO7F3gt83IpLVLEjWttZuO8GOuLEOniChUgJC4gmNNqUFwJdbSaODR4yMcp0lSE7J
	 EuufT0/VVeatDrJSDAGesbuarwiozaMKWUj008HKEq+DnIN1ky6K/wPZOYcr8clTvLEfN
	 3QyD1oB4kus6JQAVJ/wfErHmEb/sAdHI8nU9CPCIaFy0x1abbwOGbO48CFQ3R65FY6tF4
	 IYhBF7HnvzkFD9h/6F2wM2PZqhVQPbhRuqFYBU1WzlK9T/9QOlQEILTno/sZ+NZifCdqr
	 DWYTPesnNhHhrTi9Qrj5Xr4/bfZdXYczckhAXXDMKjxFa8EggjkZ+FFH43yepXFPCMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44952606A329
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 15:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44952606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBxole2317469
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:17:15 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxqtns4rn-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:17:15 -0800 (PST)
Received: from twshared25295.01.snb2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 15:17:13 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id EE54D2F083077;
	Mon, 16 Nov 2026 07:16:49 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
References: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
Subject: Re: (subset) [PATCH 0/2] nvme: use the parsed offset for DH-CHAP
 secrets
Message-ID: <179484220997.249619.15316434155149388009.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 07:16:49 -0800
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
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX2kJLoKDiu8Dz
 jw9zbMAdDtGi0K3FT25Qik4wJk0OdliYmWdG/CjOA03SVzRkmTVjqe7GiI6Xk4yiaQXpRzQEbMV
 fGdmbqHSUb07mXwOrYXgd26BA2XCu9M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX5OZc4HYfzq5r
 BcacdmjSH4cPtv+9vuSaohyKAxKi3GJYRKox09ujia3sMyE4LjW6Osg8us/WSa//iMUMK2NWtQv
 lL10EA9VRvxuIHxqPXa6Zizb/DMpSar8fRcw5d6cmnukDZa8zd6Q5gZemFdQ7IzC/UK2EV8AR0k
 C1V+We/CrpzUws38qLN/K1um01oCA8rk855uE77QT3hQ6HrXW39OddnicACeVQhCMvhaY2OpERh
 QE5rxRJHoxEwHZ0mknuTBXburo4yCXSZXruYbuaibL5SYZKVjBSCQQTyuNPd4F0PUFCQ/wRaDJf
 TJx+XInvgGOpw+WGKzmKdVO5TfuryZikzPYWBh4MDxSzGWwloCt6lrlQrSwpEScB5fPi+dyhs0E
 P3ru0zznvJRWeDE7xU1sMwNUvkY6AvkSbxYVFAKvxkb293sSr4PvJU9VzkRt5MWXo2V4RhIAVP0
 faKtXJ9ElFx/aYAFtig==
X-Proofpoint-ORIG-GUID: O1ab62vt7gGTsfvclBAumP4AeGJNeYNk
X-Authority-Analysis: v=2.4 cv=U6cHnuru c=1 sm=1 tr=0 ts=6afb1e7b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=Ru7rdtjBa1pdOxYo90UA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: O1ab62vt7gGTsfvclBAumP4AeGJNeYNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01

On Mon, 9 Nov 2026 22:59:14 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> Both the host and the target parse a DH-HMAC-CHAP secret with
> sscanf("DHHC-1:%hhd:...") and then skip a hardcoded ten characters to
> reach the key.  The prefix is only nine characters when the hash
> identifier is one digit, so a short but accepted secret makes the key
> pointer point past the end of the string and the follow-up strlen() read
> past the allocation.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvme-auth: use the parsed offset for the DH-CHAP key
      commit: f7141618d5d0b51bc2a64961bab738a0fe57e83f
--
Keith Busch <kbusch@kernel.org>

