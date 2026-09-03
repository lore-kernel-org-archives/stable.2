Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F8C2E7F20;
	Thu,  3 Sep 2026 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427917; cv=none; b=DCJsULOs9cHtsKahSQ8YZpiByHH+5JRv6K+Dt+uljkmOasSF3khQuqHKTYhI3JPwGn1pyhalwgMp09sHKIp0ZEWhzy9weYvvyFTHUJUefZfaDmoZJCfyRx5nG8/bUyhRDtNHJKaZcB+5fnU6LdDRhb5O+c9P3zdW8ll9+g5OfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427917; c=relaxed/simple;
	bh=M1GuArPDszQqhtRbvFDsXyR6Fc3gKdDpC4liGH6u+fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA9YBIf2jpdm0xK+k9xRComvlAGCpzS4R92qVvp3T9tOIK1RYcTLfVwfYuk4Vc6CvMa4gaKBpfudHCkyav2Wzjy592BdwVSueRcO8xn6o1oeH8n/2HvkcsWpHIo3KGh2+jG4MT8vYBUCxR+L8oCzGdEQDL0yRz5CTJtzxPXwL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j04Ou6le; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j04Ou6le"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68392MD92554949;
	Thu, 3 Sep 2026 09:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Oes1IY
	6tLtZP0ojS7F9/jWz9DNW2mLJCHP801lQkmNk=; b=j04Ou6leVZz1OLXCqueA/W
	Yyi7Ijyufw8f64/1JYtjIehAT6UG94yxol4bLznNmbqz9AJqRNOxSckjNcQck1uE
	IzL40AKywC9ZV0ZFRFQ02dOh3uLrFok8h5483SKoKyvS6Pb6Q3kJ8MCVpHUtrDob
	wuwF3qdoMxvanfVgrHJw7818MBnyIWBRTTtD67rJ0SpYie6g9eTjoL6Oznr1KgMq
	o/tRa/bjf2VuA5Mw2zkQrNTj2xnC6jMT0+t+NNXWsAUSCMj7yyNM6NK5U+Hu7VRS
	seWSbJsxXacS0EYDfme/E8fa77s8/1K85wFCpXK4vn52FAFEFuQ57O+kdbYT49tA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5v37e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 09:31:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6839QKxr027721;
	Thu, 3 Sep 2026 09:31:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaqc9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 09:31:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6839VKig56361414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 09:31:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 076FE58061;
	Thu,  3 Sep 2026 09:31:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B2C558059;
	Thu,  3 Sep 2026 09:31:14 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 09:31:14 +0000 (GMT)
Message-ID: <44129fcb-e898-4567-b328-693c3b25b84d@linux.ibm.com>
Date: Thu, 3 Sep 2026 15:01:12 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org, co+6a581c4284f721d4@bugs.sh,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jonathan McDowell <noodles@meta.com>,
        Ross Philipson <ross.philipson@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Stefano Garzarella <sgarzare@redhat.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260901205809.2028454-1-jarkko@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <20260901205809.2028454-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a993e6b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=9NdF306EAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=w0kG7cfk7OnRNx5R66wA:9 a=QEXdDO2ut3YA:10
 a=rgq1sGBS9uhxkUNMdZk6:22
X-Proofpoint-GUID: vIX0nz_Oxt4zQ4BLL0BIgl3RrLAIh53g
X-Proofpoint-ORIG-GUID: 1ZJ0Rqam87dI5LDuAG4CJt-2a3_NwCbG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4MiBTYWx0ZWRfX+BCe6WQL3AXn
 YS2g/5qL1e6W2Hot4135EYWaUXwzM9mBpoj6RC3dPMOSrOnsJjoCJH48u98CAaTWz4D6cbqdUWG
 P47GfeVFmULHERpuZrOcliqBflC9GiY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4MiBTYWx0ZWRfX3Ut2khEE/1PZ
 H6vC3iAWiTw6ZhaPXTRtQRko3VB1G+5Gul5uh3ChRiLFdLp+qZMSykbfpl6/1WUJZXeckiqFUEY
 f04xEhsBTGyxrsllFFrZieqxCROuD6V4wNR/a1tINopVcCc3y55CBoQDV1TR+PzsDD5Qr+sEvoO
 3wcbAQlKQ+ek3SxBAjSQ4zonSEI/MybHNpV0y96jr8UD4Sj+XNjIeoZHkNns1vNrlavGfgxhnVd
 vGj2rASbeNb0zNNkVVRGhHuQLPk6ngOvXDq0iE80QageoXZqh02YERi1RI2rS0P2EQgHwUA5SoF
 4Qi+iKJcQdla2sMytB92RwKahZLz2QoVbLG8/1pXrXxzrNCZek6HUDg4/pejp3vIwCmehWKv/Lb
 3wdbDIZCJbv0D4/9iVSj438yYHCgGmiMggruB9Zu8fqn0YJzuIaLP6PjF/YblR/dB8FjW4Pkb4J
 NoMQSFWjjMrSiklp+Jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030082


On 9/2/26 2:28 AM, Jarkko Sakkinen wrote:
> tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
> payload->blob_len. Address this by passing the decoded blob size to
> tpm2_load_cmd(), and use it for the boundary checks.
>
> Cc: stable@vger.kernel.org # v5.13+
> Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
> Reported-by: co+6a581c4284f721d4@bugs.sh
> Closes: https://bugs.sh/b/6a581c4284f721d4/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>


Tested-by: Srish Srinivasan <ssrish@linux.ibm.com>


> ---
>   security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 67225dd562a9..01f18bb37047 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -99,7 +99,7 @@ struct tpm2_key_context {
>   
>   static int tpm2_key_decode(struct trusted_key_payload *payload,
>   			   struct trusted_key_options *options,
> -			   u8 **buf)
> +			   u8 **buf, unsigned int *blob_len)
>   {
>   	int ret;
>   	struct tpm2_key_context ctx;
> @@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>   		return -ENOMEM;
>   
>   	*buf = blob;
> +	*blob_len = ctx.priv_len + ctx.pub_len;
>   	options->keyhandle = ctx.parent;
>   
>   	memcpy(blob, ctx.priv, ctx.priv_len);
> @@ -384,10 +385,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>   	int rc;
>   	u32 attrs;
>   
> -	rc = tpm2_key_decode(payload, options, &blob);
> +	rc = tpm2_key_decode(payload, options, &blob, &blob_len);
>   	if (rc) {
>   		/* old form */
>   		blob = payload->blob;
> +		blob_len = payload->blob_len;
>   		payload->old_format = 1;
>   	} else {
>   		/* Bind for cleanup: */
> @@ -399,17 +401,17 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>   		return -EINVAL;
>   
>   	/* must be big enough for at least the two be16 size counts */
> -	if (payload->blob_len < 4)
> +	if (blob_len < 4)
>   		return -EINVAL;
>   
>   	private_len = get_unaligned_be16(blob);
>   
>   	/* must be big enough for following public_len */
> -	if (private_len + 2 + 2 > (payload->blob_len))
> +	if (private_len + 2 + 2 > blob_len)
>   		return -E2BIG;
>   
>   	public_len = get_unaligned_be16(blob + 2 + private_len);
> -	if (private_len + 2 + public_len + 2 > payload->blob_len)
> +	if (private_len + 2 + public_len + 2 > blob_len)
>   		return -E2BIG;
>   
>   	pub = blob + 2 + private_len + 2;
