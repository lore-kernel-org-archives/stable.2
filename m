Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221081;
	b=id7nb5sLwHgPIbu0qg8y0EwFk61Sl1/AGUA7/DyhHMe5K1ZD+tCNOW0EEoqwl2/TKkRb
	 FHMnpAv9QeC5klQzVQ6IFFDte/c3kigXN1liJdKx5OxbmIAuyTVX6GNrKYVgel7gpqACC
	 e36ICRlNtrVw828ne5JhfijiUrSscq6HqQcCOEk1ZJjN2my3pR1kVtHKk4kfsMFj1H70d
	 TWs6E/gsoLy2jc3R0a+McxqYiOnfYX7MF3f9I3K3YTd0gZxeQgAWH+e/Y86tzklf2gPbt
	 7wjfDAAtmbhdb964JRceid/vKTjBSs776utTuCFFVsiJLHqBPx80WG2Ro49ZojOQCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221081;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=FEam6Qnluh0uJgwZEDXQ2NkiYj/d9gp2O2xgrw8uq0Y=;
	b=CGz6iRn3i7YCI+y2D0GVXtpcnAcwtmkfKhQPdc6o4yUPOn8Xqe96bivVmkiKdlbtAqlz
	 wnMwPFM7Qm85+2Y0YUn/Lx51ULvqTB+8Y5a/1ScNw/5cu7Ay54ct5C08THWK5odv6TimP
	 Pb4NdpiGD5hfIL0Oqls2Tv3VmBwq3aoY/F8HL+vCitzrH1GrOmVkTJDNV7q2NgHV4VuKa
	 R6dQmcLpeqWbyDS4ms44IaS7js4JD31fXQWTVINMzyE//htWY1Om9xLS0yPtaXOBRqUpG
	 pPsxiec5+kBFvcaAHzKg/RE7zto0e5SUCHuDaJ9pGvv6uzA22UDKt6QllERAQwe5zWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=embeddedor.com;
	spf=pass smtp.mailfrom=embeddedor.com;
	dkim=pass header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=VH80kyob;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993B606A692
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 00:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4993B606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=embeddedor.com header.i=@embeddedor.com header.a=rsa-sha256 header.s=default header.b=VH80kyob
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id UTq7xjvEYRiNxUZ0fx7CVd; Sat, 21 Nov 2026 00:31:17 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id UZ0exMQQRb2qJUZ0fxse9a; Sat, 21 Nov 2026 00:31:17 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6b00e655
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=5QcsuHF3OdXLyUFx-zQA:9 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=FEam6Qnluh0uJgwZEDXQ2NkiYj/d9gp2O2xgrw8uq0Y=; b=VH80kyob3Cpk
	omYN+PVzx9okbFA417StJ3HsjNAK8//vGxU8CgShOzuz/PP02n6kX6gaMZKWxxJeMVIzeI6dKBkBy
	IDSEeaNh4nf3wShBZ4hjtMhjwFwDzljWWwE/q3/p//V+NvUOL5IxvWDoEdWCq0LTNDkT/FAfqHKfk
	D/oz19tm38pvi0YdX+3kgYldK5NU0+T5LfMQJwwtINigzjYsU/5f2D8GZ5xfDrUzRquhdNUEWrxD+
	s7m5hjNUW/5NDBOcLQYEDvBCvG3WVYkqmOzb+I71eMJArQ23YbJCdVGJruAB8bGE/qWrvh/LTvEOA
	4B2SWXj7NvdfBrXVzI2heA==;
Received: from [1.234.115.197] (port=52580)
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1xUZ0e-00000002lsa-00vO;
	Fri, 20 Nov 2026 18:31:16 -0600
Message-ID: <7603f730-3607-4c1f-803a-ae501e41b824@embeddedor.com>
Date: Sat, 21 Nov 2026 09:31:05 +0900
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
Subject: Re: [PATCH] mm: swap: make swap_header badpages a flexible array
To: kaleshsingh@google.com, akpm@linux-foundation.org
Cc: kernel-team@android.com, android-mm@google.com,
 Kees Cook <kees@kernel.org>, stable@vger.kernel.org,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-mm@kvack.org
References: <20261120061750.2973004-1-kaleshsingh@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20261120061750.2973004-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 1.234.115.197
X-Source-L: No
X-Exim-ID: 1xUZ0e-00000002lsa-00vO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([1.234.115.197]) [1.234.115.197]:52580
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLa0b6Yz/StRqZ0cE3zhEPYpRiezW2lTxF0yvoLVhAh/pm8ry+lN5qRJVqi4MgzSHqp3C4XjXL4I4DMnPRaeKrWumLIryfyvDxYPgNpKPzxGs12wj3kV
 Kdi8DXL+gn8ZtRCsaY8Q67AbAceMilPHIGjXFQrhMoybjt5sBpz/PjiZHko+Zsm1gIyN2ialDJLuphbSjGMFptG3CEiUdcrdR1E=



On 11/20/26 15:17, kaleshsingh@google.com wrote:
> From: Kalesh Singh <kaleshsingh@google.com>
> 
> The swap header declares its list of bad pages as a one-element array,
> even though the list can fill the rest of the header page. Since the
> kernel is built with -fstrict-flex-arrays=3, the compiler takes that
> size literally, so with UBSAN bounds checking, swapon() of a swap area
> with two or more bad pages reports an out-of-bounds access:
> 
>    UBSAN: array-index-out-of-bounds in mm/swapfile.c:3674:26
>    index 1 is out of range for type '__u32[1]' (aka 'unsigned int[1]')
> 
> Kernels that trap on UBSAN reports and panic on oops, such as Android
> GKI kernels, crash instead.
> 
> Declare the list as a flexible array. The layout of the swap header
> does not change.
> 
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: stable@vger.kernel.org # 6.6.y, 6.12.y, 6.18.y
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

> ---
>   include/linux/swap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4f686709d71f..a3a98dc474c3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -129,7 +129,7 @@ union swap_header {
>   		unsigned char	sws_uuid[16];
>   		unsigned char	sws_volume[16];
>   		__u32		padding[117];
> -		__u32		badpages[1];
> +		__u32		badpages[];
>   	} info;
>   };
>   
> 
> base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854

