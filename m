Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584771;
	b=3iqJ0C6s0c0p/xbtV7OhIav/WXWSOrDFaiPNi45t8hQaiK4eDAEIwvLcRbRwBcTUxtXp
	 zbpQT2TrKgExtIKae6PiOV6PwMF/P3syMPI4L4A9eQ9OII3we/B1oZ1Rt4HTXAWjqAW3g
	 YT9U9nwzYRJGiJS7rs4v7AXpwuVVm8Z/9acCyTfOj87NrzgwJsf/bDswWtiWh6Kri8Hit
	 tCVKuxyJfzb9hNtZ7RmfQD4dZzg0CT1cCLDf9mHaOEFE0myREFvrcVtS0RDE/s4uo9XJG
	 yuWAWh64lIp8Lf9MvqCFtC0yanT6rCp/gKONcP6tzrXB89P8OLkXj7tx8HA2G2JPooQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584771;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TOa81AMcZ39FVPpdKUi4a+jsK34E7NL5Bi1fu+zvPwA=;
	b=g0kNf3mKtQ9RAlCTVNJJ8S0ZmTCq9Cz1GXPwHHUQ+xs2nnRJJxIFuEy9fh8+frS8eEH+
	 iUswMtS6bp03bYeEv0Ug6a3B7/zU11qjAASL1I6ZffAmP4dATjnw20mdmgvV6XpO/1gzK
	 +dc3hkVodPmFiMo9Xo70xaDQ0MapG3/M04vf46WOoM7X9LCPGjVzjm71KawCnmPhqiDYA
	 2cBdB3VfGV6dPKC/zQVdwzs0lnjWkNLIsbDDvZEt5YpyQAvvAOMT+Xl9CZJLgFv4vGB2n
	 WG+bOvG/tiP+XsebkUsJbSdmZXkLKR0JWf5X8X9EYYDGofKjnThRllIQ1ok8IwOOqQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Mz6kD96k;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TNNLVyBO;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF5606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 01:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95AF5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=Mz6kD96k;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=TNNLVyBO
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1EpsAi3065935
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 20:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=TOa8
	1AMcZ39FVPpdKUi4a+jsK34E7NL5Bi1fu+zvPwA=; b=Mz6kD96kVplItFSo8ra0
	2qdsM4Hk13j55ItZQHvGa91+l2LcpZpC6YSnV19GSCxGIYVbivLeQu+eSwmmdV/m
	snscUURbS+gNrPOnuJkxuAuonUERyq6VhndtrXQRj1VnhF5KSN9TIJyJ3MdULojq
	4e4qeB42BTz7FPZcCLZzdAg6g4Z50XZNvULk2re7VwZEygPY1ORu7A5IcpOk+WB+
	KXEW5sB1MF7feBUYvmO+Kltpt5OyL5TDuZEO4UpzOWJsVxGCaIq/8jFulqpD6Dkt
	4PAkKHadGxT+FGV4R8AVup96qqXZvuGFIGbOcRYU4AzVW9V5NOusxyYt3vJSmlE3
	Dg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hp7hujuf0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 20:59:29 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so189659085a.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793584769; x=1794189569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TOa81AMcZ39FVPpdKUi4a+jsK34E7NL5Bi1fu+zvPwA=;
        b=TNNLVyBOfQ4HYc2qWQV5Hs9a2k/mgCM+owx4CTV9+yAcIo0sMFPrECssRDjF+5Q1YW
         MFvEbJDOuYswJePR7P1VPKibo/wvi4sBpm96erRUvOl0VK95Qm5Q7A+zXpnE3Y4NLa7d
         k84ImLnqrB3PhoYPrxAgIvGu8bxPAFrwYf8VTyKIWT2u1HkQoomkoYR6o6Wm9k1gx2Xp
         139w8p/Tm4oKPa/9JuqRQ9KjJRNILTSM9ZaZEQ5ZY0/lzEoIqLLWu30xzdIQO3L50Svn
         t5312P+x8lcdGhJ/ZxZkHwq1Kp851yWBHo2vDxWuRCV09snirwLbUplZcPX6hsBWHGGw
         u9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793584769; x=1794189569;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TOa81AMcZ39FVPpdKUi4a+jsK34E7NL5Bi1fu+zvPwA=;
        b=zmIl1/l4kEihD+v5KWH6iBjTD6ctqdoxtIznV/kYz4UnN9hFky9QPRErqwU1z1DxES
         HagmcDu89J44+CGTOvzMU1fgqj8RxuT8vHQQKlkGfocgpwHBsb+98PWo1Mi3YclfkwNV
         5NXz79rKGTiFumjpNyRYwgV2z7nk6vweehBjJLkIiwkvMjfQph8eB4zjHZPGHQmdGim7
         Zx2oxIA6vaCWDE1NbMiW6rpsdgSDE0UkiWJBZ1uwp9Vuje5L85F2oPVBR9eouDhIBCcs
         gFEU3sNQHRmchqaMKbKZo9vTZYLnSu4/MzVpzLzTKBI+sd0y51Xz4nVYLnXTbiVxbPWv
         IrvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiCV30uUsbSZ97DERLSHSuccRguZACSZtiP8af3dAoeupQ2ExnLvrW8Vlr+iRZqkX/VrfAOu8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYG/xAT8bW2NPgYw6cNN1kONKWaxZc+1/VTmR5hoIB4KlZV+CQ
	OqOjepJfWxNauvTnYTz5x0Ehz3Jy0pnq0Bs9FwOdnMLDAXBhtAlRqWaFIX8PAxwnvnsdLh6UuCe
	Gz1cTOuGh4vc5TNbQIawoa+N2kQ/okFfUKfmF2L3HWWbVjb4tcUGKymP1216DqXax
X-Gm-Gg: AYBFou3LnuNIw17ARaq6/ZGkcutC9vHFgsXjOI1RmdSD3eDrOQLuqAeD82NVBb9ibqq
	lfdNALRC80EWDAEZIjq5E3WU0Gn4tTqHNd7JNciihKdYv0ypTsZXarkLBh2klXT9V/6HzrMFIT1
	lYin6bKR++LyjnPy/OEghXHz7MU0xfDHCPicORUT6gRId7bBHP6/dLnlT2pBpn7Ji9MMPupgz3Z
	SkCGYFvUh13KNWeUF6RY4TJ8PWl6SHXEC3W7Xdv+RIb5Jqjg+UitriLyDYbTAViBlQGL4sKMCRQ
	qHt1JxjGZV3L0oPb8N68u1aUoa6KPt84rZ0xuVp8hzxhtyqsyl46+1+5t/mJ4T7mY8WiAwvmAOO
	DFBTiTInKRYmOXav2advt+s4MyQWzv1UdNrsijpml62XaX1nFrz/8zaOAyYBcOpLb8gSKxhgZ4m
	7B2ZlclXdovg/Rf9nhO6uux3OgmiuZ0f4Lv7Cj2n2+lK2eD1gKAO9PoyDyx9CD4dNB1kgnqN1IL
	dL/FRmdsk8KnUsPuunSJze/dlEHEzB7scRSfzgxuSUYQbgxPvmctp3NYOE9O5I15XNt3wsXoP48
	dytZyDpSSFTE5pkdh8egNbv9L9mP/kkeEw==
X-Received: by 2002:a05:620a:2996:b0:93c:c405:3215 with SMTP id af79cd13be357-944216970b3mr1557092785a.44.1793584768859;
        Sun, 01 Nov 2026 17:59:28 -0800 (PST)
X-Received: by 2002:a05:620a:2996:b0:93c:c405:3215 with SMTP id af79cd13be357-944216970b3mr1557091085a.44.1793584768559;
        Sun, 01 Nov 2026 17:59:28 -0800 (PST)
Received: from [192.168.1.179] (pool-98-113-200-94.nycmny.fios.verizon.net. [98.113.200.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ac6bddsm715383785a.37.2026.11.01.17.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 17:59:28 -0800 (PST)
Message-ID: <1b21a602-aeb1-4e76-9f12-87761d89de86@columbia.edu>
Date: Sun, 1 Nov 2026 20:59:27 -0500
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
Subject: Re: [PATCH] btrfs: fix bio counter and bioc leak when async
 checksumming fails
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        tz2294@columbia.edu, stable@vger.kernel.org
References: <20261101-btrfs-async-csum-leak-v1-1-feafe7ae61e9@columbia.edu>
 <d9990870-188d-49b5-badf-9e7ae9a273ed@gmx.com>
 <3d3cedc7-a148-40ef-ac22-9aa89d0920f6@suse.com>
Content-Language: en-US
From: Mani Tofigh <mt4022@columbia.edu>
In-Reply-To: <3d3cedc7-a148-40ef-ac22-9aa89d0920f6@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAwNyBTYWx0ZWRfX5bGFxvYMSmMq
 cOaFdO0L5+dhKOwoyxMiUnAU5TiJxpcV8AAF/Sls0q0kEUOGhNBDwfHw1Jm0FofMuXnQpyj6GkB
 baiAbi43sx4xMz/76uNiDfuQcZxJzImm41NYAI+i9JAFqV0d6vJ4NizvDM2vKlqPIQVHm1/sUER
 P0pv1FV6Dky52OcPtgrb/JDlg/7afDyHu/tkcmcMMXg/c72OKDSIrbovBvyGwb+O37iREeERE7I
 0noKol+v8Hy2I+bV3yRvSX0H1gJFh5R6czYSIqDktSUvtPd9tU1QKwUK4LqJ5N37PRwFxRA5Nob
 V+1kSSztQCQP186GvHBfbFSbYBoX6ZwN86fJIAzisJqTtBUZY0riRbymPqbqcJlNOLKv9D+FgOt
 RIlp9+DV3srpkAUV09thC4Bix4W7w+UPB4Uc7nHspCpON7y4awHb3dd+NcWzg1Wwyzat3cY7VYB
 Y6XZ/BWyXBjn6mC19lg==
X-Authority-Analysis: v=2.4 cv=SZJi5fRu c=1 sm=1 tr=0 ts=6ae7ee81 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xAVkXJFauo6zK1gNGjfgTg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=6ma1GsHSQ2guFgE4MT8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: T-_j-ySBNk-lIAkvqfDQ9MbJxvVkAbpd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAwNyBTYWx0ZWRfX3DTdbeEr1QL4
 Lmd+r2CZ+L34cy1bWOoPmyTjtKhCSd8NH1nj6kPdpl6EwQRFsKlBt22Hci+DiDN9QRp6rcAJiPX
 29uiKBAD934HuEV4e28xjPHtjzE4lw4O8nqOPToZfYxWy+xjSP0e
X-Proofpoint-ORIG-GUID: T-_j-ySBNk-lIAkvqfDQ9MbJxvVkAbpd
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 lowpriorityscore=10 malwarescore=0 phishscore=0
 impostorscore=10 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020007

On 11/1/26 3:53 PM, Qu Wenruo wrote:
> 在 2026/11/2 07:08, Qu Wenruo 写道:
>> So I'm wondering what's your setup? Are you running SHA256 algo for 
>> checksum? I can add it to the commit message during merge.


Yep, it's a sha256 filesystem on a non-EXPERIMENTAL build, with
failslab failing the checksum allocation in the worker.

> And Sashiko exposed an existing problem, even with this patch applied, 
> the error handling of btrfs_split_bio() is not going to release the bioc.

Good catch, I'll put the bioc there too and send a v2 with the sha256
setup mentioned in the commit message.

Thanks for the review!
Mani
