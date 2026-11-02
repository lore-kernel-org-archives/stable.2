Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621374;
	b=R8Lj2Cal06GNEdA3gTRefGz73CEUz+VDl2o6pxkuRqochY8lpZPc9jPgxraO11hTt2F/
	 CFgmLRGS43U8JOzDeMJiaLw4QK9lJ8cgaRfzjXJnejqlTLxAMZqHi/bizTK9/NStYgdiU
	 BEzgQGRy24tmvbvTT82HhsLrg7AJGHnJBX+f5w/m5zu1X2ozDjRzteJ2Ie5XLEAEGdZ6t
	 YlkdSokb12RJgLIGJpAGY4qOF7Ny+SO9+0x97c0yhnoEFLp3D/JfTC1Nlp5iixtB9U49c
	 2b7J3Ty0OinrQd8basInfY2NrV/zGCDoZyPAA7T08tvzhM4ZqwEkWb62VqK5rV26tfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621374;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=zDL/1MJP5TL90RnmLlT28rab6xGthMP97p8sOIl7EEQ=;
	b=Z0VJ+OLjRcoyfkde1zEsa+ctvuAyVWy99tMoA90GYRIiA1ymqhLlkQiHHW0QGatW+Mr8
	 kvJlMXc+6+xNBECmd2jGrTK9iZm36kQGKS03j+L1iPPh/85JzFi1YQJmFA5IO7g6mEvNL
	 LKcZ270IYmki4wRPJXN3ZMMI8i6HkD8LP/lYvLEl0H59PmQ1IdZJpkMj/aWLc6JkOlbp+
	 U03QDA7nDJLYxtfMjL1RO+VEIXnP9uPulEUuyI5V1l7dOAssW5HOaWtUWRepvruiQFDMq
	 DU20I3sPq5tunqvUwVXWW5/0FlaiwCQ8S7Wfkg7VMfB3fBZc7l0t+IqOTmrchAnO58w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HvbIScFW;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63C606A324;
	Mon,  2 Nov 2026 12:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E63C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HvbIScFW
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zDL/1MJP5TL90RnmLlT28rab6xGthMP97p8sOIl7EEQ=;
	b=HvbIScFWhWDTTwdBbxrP3FBKIxxzLq6vdCLd3CxwXmjXza36bZ9JLJ85pSqVCOL7Jc6SJzscn
	xMecTl8mvn9SMF7bifpcbLHa9B1shrIXtYYwfOzFCGK44CxuVI26qzK2u2jvXMktjmxON+4PGet
	nycjVKozzc+PHEVs2HJje/8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jJ9VD4qJZz1T4GW;
	Mon,  2 Nov 2026 20:09:08 +0800 (CST)
Received: from whupemk100010.china.huawei.com (unknown [7.152.184.41])
	by mail.maildlp.com (Postfix) with ESMTPS id A0AC8203C8;
	Mon,  2 Nov 2026 20:09:25 +0800 (CST)
Received: from [10.67.110.140] (10.67.110.140) by
 whupemk100010.china.huawei.com (7.152.184.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 2 Nov 2026 20:09:24 +0800
Message-ID: <faee04cc-fb04-4e56-bfe4-1eae5b819137@huawei.com>
Date: Mon, 2 Nov 2026 20:09:23 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: initialize the real inode attributes of the iint
 cache
To: Mimi Zohar <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<amir73il@gmail.com>
CC: <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lujialin4@huawei.com>
References: <20261102024703.816178-1-caixinchen1@huawei.com>
 <cb3ef53e2e5c6d74051528c2b9b9c0a294d6c119.camel@linux.ibm.com>
Content-Language: en-US
From: Cai Xinchen <caixinchen1@huawei.com>
In-Reply-To: <cb3ef53e2e5c6d74051528c2b9b9c0a294d6c119.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 whupemk100010.china.huawei.com (7.152.184.41)

Hi Mimi. Thanks for review.

I mistakenly used integrity_inode_attrs_store. In the next version, I 
will directly use
memset to initialize the real_inode structure.

I double checked b836c4d29f27. That commit also added real_ino and 
real_dev to struct integrity_iinit_cache and started reading them in 
process_measurement(). However, iinit_init_always() only reset 
iint->version, leaving real_ino and real_dev stale. After 309e2b775da8, 
these three variables are encapsulated into integrity_inode_attributes. 
Therefore, I believe b836c4d29f27 is the appropriate Fixes tag. If I 
have missed anything, please let me know.

On 11/2/2026 7:20 PM, Mimi Zohar wrote:
> Thanks, Cai.
>
> Instead of calling integrity_inode_attrs_store(), reset the entire real_inode
> structure. The store sets dev and ino to the stacked inode’s values, but at
> allocation time there are no valid real-inode attributes yet, so the fields
> should be cleared. The patch only works because the stacked and real inodes
> happen to be on different superblocks.
>
> The Fixes: tag looks wrong. In b836c4d29f27, real_inode is an unsigned long
> version and init_always() resets it fully.
