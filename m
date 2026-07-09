Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372A385D8B
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608448; cv=none; b=peB5Xkn7MyLqSVmVmR5grjYqIEwsI1F2rY+KnCJdnoHLtoZ0w3FEFxculV/8R25SMNaEBa/zRvWkTKo2abNtQU3fpGYcFlK7B6vicVPhaksXeSWlbfsbxkLXXL/Apd+OGu8NXe67w3u2zjBchhsuSVjb14OrKnJXV9/GLrucTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608448; c=relaxed/simple;
	bh=2wJW7b8z5lFIhuQOA9BU8TOnoL28pH+7/ZAj4ZgsTsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFbKT6cNUpsqbiKyQ1g865cGcjRtzmKKddPOVrS1hv3I9h2lGHsfPk1N1+YW5A56yvvMNoffXMDlVcabsxwqyXSoteu1iVoHJHW31Sa4EKD8MGGGp3LylQQHX/swIK/yEahTlnWpZSHtCGrPqxxpcZC/nQg2X06au9O/5QPhPuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VM73xEQy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VM73xEQy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EILBL2408887
	for <stable@vger.kernel.org>; Thu, 9 Jul 2026 14:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ayspLL
	3FAyE4BK1gUgYANw9lQIls87j/4qJJnE8wDpY=; b=VM73xEQyhZLejWasw5Nogb
	gMaWHMvrTfbYJceWbRPCdMWN4SQ0PK2gHu8zKjHuowdcIecz/p7K/tiRiqi5AO6m
	c5NPbabnk5GkHWsdLoGYOkl2nBbKV5rFNefDgofDIGlqUTWnEEIo6K/EehlWO4qK
	rbvKNZKhmSmB4uBJJBLNAmCRj6YxzI2PmAdYXQQfTPbAlN/Nio9pVu8mUimy03Xc
	TgDUGUaaBB/uJ1ah8QzORylKogWvveqShXIdfPtwadHFofvzRp4HLI/00zVCdLZZ
	xqhxNn6uo652IyPRWYZA0qn6N/lD3RGX3U8DrhFdFH1ywh6cAaxP5PAzHLsJnKdg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp42a4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:47:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669DndhD030536
	for <stable@vger.kernel.org>; Thu, 9 Jul 2026 14:47:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkdjyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 09 Jul 2026 14:47:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669ElIbX57082246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 14:47:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976BB20043;
	Thu,  9 Jul 2026 14:47:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6EE20040;
	Thu,  9 Jul 2026 14:47:18 +0000 (GMT)
Received: from [9.224.68.161] (unknown [9.224.68.161])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 14:47:18 +0000 (GMT)
Message-ID: <e439fc52-e46b-49cc-b637-11db3b6acf0b@linux.ibm.com>
Date: Thu, 9 Jul 2026 16:47:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/af_iucv: fix use-after-free of listen sock in
 iucv_callback_connreq()
To: Hidayath Khan <hidayath@linux.ibm.com>, aswin@linux.ibm.com,
        pasic@linux.ibm.com, nagamani@linux.ibm.com
Cc: wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com, mjambigi@linux.ibm.com,
        sidraya@linux.ibm.com, stable@vger.kernel.org
References: <20260706084825.6231-1-hidayath@linux.ibm.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20260706084825.6231-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4fb47c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=R2two0n6AAAA:8 a=VnNF1IyMAAAA:8 a=Gr6UgMjOUMMtFO0AKnQA:9
 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX4BopwLO73ZHe
 /m8YudheP8H9Ct3VEMFY5KTN2mbGeKVN439wZ/waHLwLCmDV3E3CZFMux5BUWPUvR0fkF87i8Zh
 uKsZzZ1k9UoGyvn3aPGUR1/usbCj/Rs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX6BM+QdBabx0B
 +WGFSHgBjvI0N3WbTNQ4A5B3knQJoy9Ty6ZpW68ctwtVV+y5MxR3n3dCR2Ds5ezgfZWmr4fuc9S
 QbxsgX9XDyNwRGAeP9Zq9WcQnvoskpK1cK7krYQH5XI3b3ziVZP2sT6OnqLNcVnRAWhoqFvEOZv
 hw96wL0kj6lJb542WlSWSHpPNVp033x+bekXVaYiN3y+6gXz0qouWEGPKnpMrQtcO9fxRGbhMjp
 36qiSC9zpdKvzCg4cuYHBk+kC1rl/UU47DTnpT1j54ZfETA1JW8uGfbBP93nxy5tnSbNg8vNE5Z
 jKzwwa1L4j4EWHnOG2gYew35z6kg7TGTu3lf4BzwV7AprRXJnVwf3t+dAfguev8ngGf2jf24A0j
 Pd7iie9vkrzsOageYrYnXkyjJreRhUubwub+/3xQNDS0Pr1Wi6KWuQpHPulDhQkniYJUfBoYlDZ
 MwgcLVtf6+8LUAX8I5A==
X-Proofpoint-ORIG-GUID: z8mrOdc-1llC3_xGfI-CLi04ip2daOvM
X-Proofpoint-GUID: z8mrOdc-1llC3_xGfI-CLi04ip2daOvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090141



On 06.07.26 10:48, Hidayath Khan wrote:
> iucv_callback_connreq() looks up the listening socket in iucv_sk_list
> under read_lock(&iucv_sk_list.lock), drops the lock, and only then
> uses the socket (bh_lock_sock() and the following connection setup).
> No reference is taken on the socket before the lock is released.
> 
> The callback runs from the iucv tasklet. A concurrent close of the
> listening socket does not synchronize with it.
> Between read_unlock() and bh_lock_sock() a concurrent close on another
> CPU can free the socket.
> 
> Fixes: eac3731bd04c ("[S390]: Add AF_IUCV socket support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> ---
>  net/iucv/af_iucv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index fed240b453bd..890d9df5ae36 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1616,6 +1616,8 @@ static int iucv_callback_connreq(struct iucv_path *path,
>  			iucv = iucv_sk(sk);
>  			break;
>  		}
> +	if (iucv)
> +		sock_hold(sk);
>  	read_unlock(&iucv_sk_list.lock);
>  	if (!iucv)
>  		/* No socket found, not one of our paths. */
> @@ -1684,6 +1686,7 @@ static int iucv_callback_connreq(struct iucv_path *path,
>  	err = 0;
>  fail:
>  	bh_unlock_sock(sk);
> +	sock_put(sk);
>  	return 0;
>  }
>  

Instead of adding another refcount couldn't you simply move bh_lock_sock(sk) under
iucv_sk_list.lock ? Like this:
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fed240b453bd..84a3f65b7c13 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1614,6 +1614,7 @@ static int iucv_callback_connreq(struct iucv_path *path,
                         * src_name == ipuser[0-7].
                         */
                        iucv = iucv_sk(sk);
+                       bh_lock_sock(sk);
                        break;
                }
        read_unlock(&iucv_sk_list.lock);
@@ -1621,7 +1622,6 @@ static int iucv_callback_connreq(struct iucv_path *path,
                /* No socket found, not one of our paths. */
                return -EINVAL;

-       bh_lock_sock(sk);

        /* Check if parent socket is listening */
        low_nmcpy(user_data, iucv->src_name);



But actually that doesn't completely close this gap, see my commit message for
f558120cd709 ("net/iucv: fix use after free in iucv_sock_close()")
Iiuc the socket locking in AF_IUCV is incomplete in general.


Some links I stored for my reference (there may be better ones):
https://lore.kernel.org/netdev/1280155406.2899.407.camel@edumazet-laptop/
https://wiki.linuxfoundation.org/networking/socket_locks
https://medium.com/@c0ngwang/the-design-of-lock-sock-in-linux-kernel-69c3406e504b


If you fix this correctly it should also fix the HS over IUCV recieve path.


