Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897431;
	b=MuzuxEhkLJ3wMYc2lrQqPpSBidesPK/gDq6J4xujollxWLYRmMm0X0b5eNPFoYbUKIWS
	 POe1KL2r7Czq4UTrBFtzji5eeXydlp7djCpEqF47h1YA6M0GNX7bHFp362VkbgQOq6nFh
	 aTH9CwLFClb5S2xxXDzw2Em65eZ7bO9WI+snWrVtAYTB6xenhxqzCYsOTm+Vtn2R0XCno
	 IlyldtW2oRzqeGinER6yfKS7IL5uEOz0tQMa0MEI3Yi3fN6eLS8sLv87VHWN0VYF0VBUs
	 8k3RKrYGJZOI2PvfnTeWeYosYw5m5i0xyQL8ItGM9hP25e0uTcpizDlrGAIt5z2Eejg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897431;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DOsBTsM8HzI17SPUr1ak/9a9bMUvOh6RzD9t7xsTYQU=;
	b=yRStayWYUQpKZRQv3Kec7n+GYmKuA1GUpYd/VV7VeD3iFRv96QPchXKsL/LMmquGWfVc
	 lqWsz7IXC7d9j6Zkol0TUW8bvW+c7Aij5AW0kheUfRYLxtw19C7FrUxpB0QYt+4BrAxHw
	 h+tPVZXNitoCV0b3ZKEH6oicJsXM/lQjVgT+d/c0AN6SVnKoNnElwpPz/4JMhOF0dVh8p
	 UCCrRe0yCglR81C5hrkGe3pw2yYNRA8GxjutFm9AD2myAR47ZCAFQMh9MZSSuJ6rDz7sn
	 hTC7gq/AJvJ+IpfPLjAcCKc9ZYEjp+zxweVfV9mgyF8zIl5Pqo/zMmAOTu3SuOpdNRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=MauZHBO0;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=NAacnamq;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560F606A329
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A560F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=MauZHBO0;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=NAacnamq
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH5jMf4621386
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=DOsB
	TsM8HzI17SPUr1ak/9a9bMUvOh6RzD9t7xsTYQU=; b=MauZHBO0QHOwDKA+XX+b
	5NPgYZ4th7Jzs/pn2qwSByCnGvBsaSJc5coSVdGgWEdboi7jundzHOOM5HiM42WB
	w0OyBmo17RGT7CtiNHkic9OwrbhIuAIOKMz1xyVIP0oacCdQoPCmhkkn2AmamZC7
	mBeSrbxoXB6igxp5uzLLa4D2IFme7QvqvquEjuxdUxnBQA6/IHFDWpw05cjVR1nA
	6pqKykASzKK8FkuSYbOtbsrqtnG1wjANodQW1tQeKxZrnFbvlYJ/Evk7urX0feCD
	FDfewHX0Jj2Ys1Zg/kZOA96usAUZAlS01YBpxaYovi/Ep2sJWUyQKe5egD9ZDAKN
	/g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j0fc5gd5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:37:08 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94970ad532bso377595385a.0
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794897428; x=1795502228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DOsBTsM8HzI17SPUr1ak/9a9bMUvOh6RzD9t7xsTYQU=;
        b=NAacnamqM/fJxKIaGIq/+aJuJkRwcvSvNe3PsFCVhJHtQPEw3GkpqTnt/Zu7OcjRdT
         UYcULCikl0UsUFK7F/oizAEr6LQbCZxFxLsrE3/+DL+AZabmY1fPMMPxnaXOARdgk/kS
         7FtXohksQSwnIhBJD5Q8vUjq+2XaUxgZRXz6ABlYlAtyOqPqJ+qXEiV/mxrLFh7IL+BW
         E66PCqzKKXM39dzvJG/5vQAY4Q6GKslyig7ktMrD2pnKs4TlqnVcjZCIBAfXpjDDi9UA
         M9ZTTlfkok64SL9B1bjUUd1NbcwDazSidl81OPTvoUZ6uQZ8PhzakvysmIFfAwRy8gLV
         KMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794897428; x=1795502228;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DOsBTsM8HzI17SPUr1ak/9a9bMUvOh6RzD9t7xsTYQU=;
        b=mAKKmIt4Sqb92KdBlU/uJS03rMMc/AMYYZn6zg/m6/XyXdoCXyZQS7UUrx5Pe7r3Gw
         uggfAx8K8w/zKgDUt5urchEsRFDbLJpth4dmL9/8xUkTPRIK7EeaznXqGEciUpbY4Tdu
         it88y/UolMI+4qE+ptv7l8PLVo0F8Sn0sQlrsaomqbYh8hTpbmNG2PcxKrGIOA3wMyEx
         Tnfhb90Lw7PJyfbIdYH04n2yFLV788toIkVx8ilNtQl6kjpzCb63kAcBgYdL0WpfIrrV
         H5FRCGxmcl0cyaeIyzX3LQbi6tBqdpz+hCRlpW434QSQKRwTDRUdjYzBPbSbJr1mq4FW
         8I3w==
X-Forwarded-Encrypted: i=1; AL+hErHWi+cLZeY5Ixo/HUJGvVvCd83xcQLSuB1t+XGXp49UG69rhEqpCfVS6C8pHL/Z+7JWCiSBu20=@vger.kernel.org
X-Gm-Message-State: APuU4Z/p6YxjnF9kogjcH48ZzoUutEz8u/ueYnKCX2qz4JUBQj9LAheG
	u3yueHQtZmYRmvJhYLPSjxztrcIYMvfUXeR3Jr1gbMmrcpokJJqt5+2ju+afBkz2wzvSD4OK2fL
	5piKItN7qPHV3ib5loFNv13qn2+7bop6P+4N3rjf7l8lhL8Ligd1VAAf7p3Dr5A==
X-Gm-Gg: AYBFou3VjYCBwJcHBMyB5Dwl6Stnd34Bk/dSfkC9E+/N0lFtRyK1X627sMW7Y2UxcXx
	uixjEzYufoc7au9YCgyLLtO/y1egRE0wnZa6OVLqItHNdDtwrpxEvD3hChYLaPFgMz3MCaDVesC
	Yauroa/5qcH27A4cn4AZFELuwqeSUdtZjxcAvbKv99u8a7URoOAjWkyOaks5CAKW7nzj8OwOXGy
	S/z9Tk2P8A1waZnpdP8BfVcd3xCSn6geI/BiSrJZZ3ban7A+jmA3N/tI9kWv2P7umWLoWPB5tD7
	OIYYxhi4jiSmPAM7roLMy57sMOqHcyHeslib32uODsFy7e8tKAuibtPlipVRdj4aJiWOkLN2rcV
	/nXZQDhPmyPEauvyAoInbPhMWvNBPKvy43oVw1VsiGsBUvENKAPj2f3UwMx8lAl/h8108RVNZrp
	BTHAJMqv17aKR1JHlXom5SOQ==
X-Received: by 2002:a05:620a:2b46:b0:949:6898:2e4b with SMTP id af79cd13be357-94968982e92mr1269464485a.66.1794897427873;
        Mon, 16 Nov 2026 22:37:07 -0800 (PST)
X-Received: by 2002:a05:620a:2b46:b0:949:6898:2e4b with SMTP id af79cd13be357-94968982e92mr1269462185a.66.1794897427441;
        Mon, 16 Nov 2026 22:37:07 -0800 (PST)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d614b4sm104980356d6.18.2026.11.16.22.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 22:37:06 -0800 (PST)
Message-ID: <8092de9e-3146-4fe7-a235-01ea8efab08c@columbia.edu>
Date: Tue, 17 Nov 2026 01:37:06 -0500
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
Subject: Re: [PATCH v2] mm/madvise: zap markers from guard regions
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        David Hildenbrand
 <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20261113-disallow-uffd-guard-install-v2-1-9d0063c70542@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfX4z/upHGYQIQq
 8oUiwhKi9zui/9HOSCZoXHvzYjnbGxxr8h67jo/7UinDM6nyBqbfymOqopGzdkzkRnGNSi+k83B
 7K9T4nL3zelP/eAKVCc4Fl+z9rAaHdlelTWQiYfDdNgWlDz4E5ueAwuzekeDww6plqTKp8XANEi
 Dxqs/DYhy2pPf+wlLv4ILYaua8hztVAaHFvpyP+OggH9z0AORQelkxuOlRm+DC27lQZx8pz+/As
 N8d/W3DafrUzyTPz2HBrXHzxV8So9FjMGskdUS2sY9Yi55eu6KJ8iWSbsxbCutpX7MrrKuA1WyK
 DBH8B9wIlYGvoeUk27je9eXjsZeAdzmQmUYO9N/kFrti7GZ+YcySunXD4U35r4bSkCCk7WwBWVJ
 cTpcAogD1v+GiMZFxqnEaMwdSGLTSDkQY5qFGEae4pz72RXW4rssG/uRSe/H9wEcriMQ26cl9PY
 Tw1UQ2ilf/C4/0hG35Q==
X-Authority-Analysis: v=2.4 cv=e8CT2qp/ c=1 sm=1 tr=0 ts=6afbf614 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=nc3XcxN3xHuRbhElZrYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: SNSpRAqUFlK4BXh6i87YYqUHf4nMI218
X-Proofpoint-ORIG-GUID: SNSpRAqUFlK4BXh6i87YYqUHf4nMI218
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAyNSBTYWx0ZWRfX/5zO2hC9hFXx
 UJqDVusb0GXTQFTU51fPVaHXDbFfGmO2YW1MrDmZj7iR5P3facEiOtX7QWGd6RWUCalmzneaX2r
 370A5CKBrpFYjRu5SgjY/h2I2JQMKlGQwqScK/nwgtJc/UsnW0+N
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=10 lowpriorityscore=10
 adultscore=0 bulkscore=10 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170025

On 11/13/26 4:04 PM, Lorenzo Stoakes (ARM) wrote:
> In order to establish guard regions, guard markers are installed in the
> page tables of a mapped VMA.
> 
> However, problems arise when one tries to combine this with registering a
> VMA for userfaultfd, as such operations may themselves need to install page
> table markers such as uffd-wp.
> 
> When the installation is attempted the guard marker prevents these markers
> being applied, which can lead to unexpected results (especially if the
> guard regions are later removed.)
> 
> This is especially problematic because guard region installation causes the
> regions to be zapped first, meaning that the removal of userfaultfd-tracked
> ranges will not be logged in this case.
> 
> Additionally, the uffd-wp page table marker will be propagated regardless
> for file-backed mappings as the zap being performed does not clear these
> markers.
> 
> This is problematic, as it can cause repeated failure to install guard
> markers resulting in an infinite loop.
> 
> Therefore, update guard region installation to invoke the zap with the
> ZAP_FLAG_DROP_MARKER flag applied.
> 
> Both before and after this change, uffd remove events will not trigger on
> guard region installation, nor will write protect state be propagated after
> guard region removal.
> 
> This makes sense as conceptually, guard regions mark a part of a VMA as
> effectively unmapped at the page table level, and removing the markers is
> like mapping the VMA again, over which operation uffd markers would in any
> case be lost.
> 
> A survey of open source users indicates nobody is relying on installing
> guard regions in uffd-armed VMAs. Software including glibc, android,
> tcmalloc and CRIU were checked.
> 
> This change means that any already established guard regions are removed on
> zap. These will be overwritten with the newly installed guard markers on
> success.
> 
> However, if this fails for some reason (fatal signal likely the only
> reasonable cause), guard regions may remain removed, and concurrent faults
> may succeed in the interim in the range.
> 
> Since the installation failing guarantees nothing about the range being
> installed into, and since success overwrites with guard markers, this isn't
> an issue.
> 
> Since MADV_DONTNEED does something similar, abstract the zapping to
> zap_range() and call it from both places.
> 
Reviewed-by: Tal Zussman <tz2294@columbia.edu>
Tested-by: Tal Zussman <tz2294@columbia.edu>
