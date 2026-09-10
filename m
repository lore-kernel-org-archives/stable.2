Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7B3B8D79;
	Thu, 10 Sep 2026 04:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015525; cv=none; b=a+ovE4qBVXHodLFs5Y3LkNotGxtd/k+Qg//UrYksy2N3Y/7r3DOZ8IZ/b6fhkmuwcB9ef3KUMBoOwGF2jg7+gyBLAs0pBqawc08Rhyr66PgoLJSKdijnTyj0PzVr0gfwD6YKGi+8Mabj0t7qmlg01E8QnqOUynQ+j6nJa3kaLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015525; c=relaxed/simple;
	bh=yQe12d99Rn305gPi0P4nNv0qtfQGs+VD9cmRc4inoxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2/pjzFNrAEiqI1SOcS607t0TISdaFPWNGehJitlYiPEpj3U/7g+DL6amqFNFruI2tUCj7xcIX4e2wpvyZ4ySd9n5jXIACtXeMREAgj7wCsOtJvbYmhvN687rL05h0ZbsPUWMmiXIySqStPZG681OoJRg7LHSod6hvLaZ2WvgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YxHcM2J4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YxHcM2J4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A21dsb3820627;
	Thu, 10 Sep 2026 04:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=937gEZ
	2FAmvZr3axh7N0QR7cgV6dr8mEQI5M5QgHgXI=; b=YxHcM2J4ZP25lbnNP9pyrL
	IjDVN8ywBNMhOW5z9n5G5I3nDrD2ttFP/3rCYYx62WzTgaPnKMVOTMRkAH12jWrO
	EFYYy35jBMZBfd4N2pO2uxBeHS6JhR5UrdgdoRLngylnEAMk+Evd6Z9vU1bvqQzU
	7mRN2cmm3HmFG064Bz5jrxl+Z8m7YMx/1MSmL6mXyr2GpVFOQaVJVvAFjTk08r51
	5J6z1CV6rKtggvABwNU8GaZl2ThiwgVXOsq3b5I2tKdWDteVkH+AYUCCe6PuLmlH
	WzVv8kYJUt0gHL0XVdYWFRJZKPH65ihTa65ZmkFeKM/6MABTtedjhP0odltm0hgw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n2bfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 04:45:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A4frwP026362;
	Thu, 10 Sep 2026 04:45:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3afde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 04:45:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A4j3Fc32702916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 04:45:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2115E2004D;
	Thu, 10 Sep 2026 04:45:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68F6420043;
	Thu, 10 Sep 2026 04:44:59 +0000 (GMT)
Received: from [9.123.7.154] (unknown [9.123.7.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Sep 2026 04:44:59 +0000 (GMT)
Message-ID: <3e27a805-36e7-4423-b3d1-4e84b4c8f434@linux.ibm.com>
Date: Thu, 10 Sep 2026 10:14:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KEYS: encrypted: fix integer overflow of datablob_len
To: Cen Zhang <cenzhang@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Roberto Sassu
 <roberto.sassu@polito.it>,
        David Safford <safford@watson.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook
 <kees@kernel.org>, Francis Perron <francis@akrites.dev>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Akrites SIRT <sirt@akrites.dev>,
        AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
        kys@microsoft.com
References: <20260909153433.83117-1-cenzhang@linux.microsoft.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260909153433.83117-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa235d2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=ZF_tswfMEFhI52YJ_YIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K02mtE-9mGZEow58vsVAn98gQ74EIdlk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA0NiBTYWx0ZWRfX9kUgJQaK/9wc
 IChmPO7hXQorYWU00xyP9JmnI+HqfTem3kVSk5zo1mvIrOTumQeYsRSSfm7sTm637qIfvWAM6ea
 M7WB/Rnwu+hC8IMtMf5Jl6HdhjMH1QY56v5hjebBTh3q/wj+TCmtsHWkCeJY7wBtrh886KwRe5I
 0zSth3J3ZQ8jhlGik5w6Uf0VFjJoeatSNvhiodR3er1nRaAW3Sq9aXaBYiJLq8Y/ukjgjQDUvD/
 hSJAoZ483xeloYeIbIQPmU4DesrKlOhZOFpH6entJzYBnDHsSQ2UM98Un5afVfXWlaYj1UFdpLj
 Evd0u35FLG3bNzl6UMpBbEykKMZybqwPOhMml8Xm+QG/bmjANk1XnjmPgVSvSYmi6gCA9WRltI7
 bFneyJ/F6kXtMMJKAhc30x+dyJakln0SdxgwHGfmDz2co8ZKFp77L9YbHMtgfQG25UG1SgR12Lq
 ghRCwbEnNyE2TQP8KtQ==
X-Proofpoint-ORIG-GUID: K02mtE-9mGZEow58vsVAn98gQ74EIdlk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA0NiBTYWx0ZWRfX2X4lLwQAyquU
 CBE8t2v8+1LZYnVuYqsnmduD+gY0cYvk1xGGBXDWTkzVpNBhkTdZ/DiYm9UubbLbJEvuDYwsKmT
 Yny+BiCvC7dQ5cUZIxPsa7qFDfXKlMA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_01,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100046


On 09.09.2026 9:04 PM, Cen Zhang wrote:
> encrypted_key_alloc() stores datablob_len in a u16. It is computed from
> multiple string and payload lengths. If the result exceeds U16_MAX, the
> assignment truncates the allocation size. KASAN reports a 32760-byte
> slab-out-of-bounds write when __ekey_init() copies the master key
> description into the undersized buffer.
>
> The total payload length stored in key->datalen is also a u16. Use
> check_add_overflow() to reject values that do not fit either destination,
> and use kzalloc_flex() for the flexible-array allocation.
>
> Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/keyrings/20260826154456.85974-1-blbllhy@gmail.com/
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang <cenzhang@linux.microsoft.com>
> Signed-off-by: Francis Perron <francis@akrites.dev>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
> Changes in v3:
> - Describe the bounds using u16 and U16_MAX and simplify the commit
>    message.
> - Include the KASAN-reported write size.
> - Remove organization names from the author and sign-off identities.
> - Remove the unnecessary off-list discussion note.
> - Use cenzhang@linux.microsoft.com.
> - No code changes.
>
>   security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
> index 59cb77b237b3..e07092ea301a 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -19,6 +19,7 @@
>   #include <linux/parser.h>
>   #include <linux/string.h>
>   #include <linux/err.h>
> +#include <linux/overflow.h>
>   #include <keys/user-type.h>
>   #include <keys/trusted-type.h>
>   #include <keys/encrypted-type.h>
> @@ -579,6 +580,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>   {
>   	struct encrypted_key_payload *epayload = NULL;
>   	unsigned short datablob_len;
> +	unsigned short payload_totallen;
>   	unsigned short decrypted_datalen;
>   	unsigned short payload_datalen;
>   	unsigned int encrypted_datalen;
> @@ -632,16 +634,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>   
>   	encrypted_datalen = roundup(decrypted_datalen, blksize);
>   
> -	datablob_len = format_len + 1 + strlen(master_desc) + 1
> -	    + strlen(datalen) + 1 + ivsize + 1 + encrypted_datalen;
> +	if (check_add_overflow(format_len + 1 + strlen(master_desc) + 1
> +			       + strlen(datalen) + 1 + ivsize + 1,
> +			       encrypted_datalen, &datablob_len))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (check_add_overflow(datablob_len,
> +			       payload_datalen + HASH_SIZE + 1,
> +			       &payload_totallen))
> +		return ERR_PTR(-EINVAL);
>   
> -	ret = key_payload_reserve(key, payload_datalen + datablob_len
> -				  + HASH_SIZE + 1);
> +	ret = key_payload_reserve(key, payload_totallen);
>   	if (ret < 0)
>   		return ERR_PTR(ret);
>   
> -	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
> -			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
> +	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
> +				GFP_KERNEL);
>   	if (!epayload)
>   		return ERR_PTR(-ENOMEM);
>   
>
> base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8

-- 
Thanks and Regards
R.Nageswara Sastry

