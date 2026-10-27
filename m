Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793119656;
	b=Ol8Au/KdglJ8xQhjEjNlzLngQah38FiMPTK3taTW4huFM5ny2+F4inQVeRQ4azbedIO0
	 D2S4U65H9RP5KTwAkbE0L+u+XoL4R0rSzIB3dsxM9CFw+UkB4LPyPF5/P/C5ryv9Yz3pi
	 3rphOLaXjPe/cPjz6bsMwgjt6GnyKOhzSlvG8Tub2cHKt+BkglAwxOXGnsmC7WMiQPY0R
	 Ny7rkto/tTxIGo16r6TyMTnUK/ly+CoBKW0Qt5lf4AMmmWDgFN/+28RhtKXi3/b+QMjKa
	 8KSHwM2rk3XmH9HESDIBoYLYHgG6PvSAu1ZR2JuxRhulUWKUkPaaJdzoRS5mKwlQw/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119656;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=7RlopbpHsfSD/OHRLgQiY6wQ2MChlTJY7NnjiKCoORg=;
	b=qvQL0SyYi/Y9bxoX70MV5rRwDU6clUK//RF5QRCaKK8ZDlabt3LMvWqgBzYa2KRdygqL
	 ZN9PJ/0kQn3BfjTNwPdK043/PHGkEHH5QSi48/KzuCMCjF8VpbYd9eRq7+ONVWNZQSCC5
	 bcafIjtevw0Sdd3cC7tu5MTXI3rBAYIk313Xr/mmU2KGU9NG5pyE0C8c7QvKK5Ud9nraK
	 HjWgRSH7JvsG1c+GNhwCZ4IZWDFA3U7ogG3gTQyfYn1e4Vy7jTW/Gqwo8ZbMTNa7gL1UM
	 BTmPewJV7fG4CG0wyvg6g/8/mBh6SsDpq4ZHEPUkHUneUX8xeRfsEHMzMGt14ukOppg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=g2kji7Jk;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=5It0pUNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7DA606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7DA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=g2kji7Jk;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=5It0pUNP
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RGXgwW884794
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7Rlo
	pbpHsfSD/OHRLgQiY6wQ2MChlTJY7NnjiKCoORg=; b=g2kji7Jk4RhgPJwv9HHA
	naNWY22THk4WwGe/onm8xh1Uf6dP1LvHroRUCU9ynd3jMTEYToa/hG0mRCRIjw9j
	hnPUmvdzWwYwJg3sN7pi5HbbsaZiHumQQ9a8dEal5SxjjUiHlqBEPyf/6fG8j3bE
	c+cy9kt2nG2sLEKbRjW7w97kJOnyT7NIqdEWcsarsYIq34oMN0uLAlSLyyt8SHer
	oyMuJjnx5p5gns/Wk2/Q36cpP1YQntoEPCF9GNxcDnzIOS+QtzRE2yvZ15wpsVMa
	qBgjNPh1CPUgHKr7LVVAlF/S/MGglB+Gbh0m83oOS6xF8vihaD8JdjCAxMhT8dTf
	CA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hjq5cm12k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 12:47:28 -0400 (EDT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so79715a12.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793119648; cv=none;
        d=google.com; s=arc-20260327;
        b=CqWhnQn322kbqrIqJEcBVmO/KREvLKQkFR22FlOBQVsUk1pqPyhtjXJxSSVkVjP6Xj
         rc53P9oGCBeC9v3AhZj009a00TalH0vk3//K0ci05WcpdCHbVJ5sN+yCoMcnJJsc49oC
         rbHnKW2ZUhrttxNrRWoiR4e0tIsMEpxoS1MtPwVqya0rj9308GVuAFxP8NtdZSzALTiZ
         f0d2vM60vDFAsi4NPO5cdDhnPkbVguZGUKKIILcjsmY+6SLCMANXC0+h8fckl+45WZ4/
         y4xxYljYRvjzzmzmX5j4/6OPSBFV6PXsjBlKmcgrjSRAnFinJGJCfT2j9IdUcFY+/GDn
         qObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RlopbpHsfSD/OHRLgQiY6wQ2MChlTJY7NnjiKCoORg=;
        fh=4N8Ua/pMOF/tJZSjR8QYHK5Zt7uzyAMtMhrmTTB0U6Q=;
        b=ntP2iy+p6uHgOEroiJxR7ZqE5GOpDPh0yUSIwBa3vXdUVgf1CzQrURcmgNf9v1F60v
         AmK3BXVFXuPkzt/hcTZ4xDuZ93syT0WGZ0YvyIHABXucHz5Mqs8bGIp0lk4l3jWDgzRm
         TqyHNli4pPaJXxbM2Jg/kGNN45xLknsf2CqPL9RajtTs3KkX+3mlaIN37bkv2sxHSPLX
         hR9hkVRSjoU2CWEunR1js6MaTNfX8w59qhO4ofMSd7Dr4kdml71CjowUu2pAzDLh1mTm
         rHk3q4FbVAR6QiK1gazLc0sn3CYFphpPgqeUTmGEIo9Q6Xg9xjoRi2qEYEGUqO3Mb5mr
         qi5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793119648; x=1793724448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7RlopbpHsfSD/OHRLgQiY6wQ2MChlTJY7NnjiKCoORg=;
        b=5It0pUNP6sAU0UJq7v+0TGbOJTxxfbRZZz6AU4F45uLNdu/KdMpHxt6YLS1opcxm8P
         SXZz9ov+xgP+/hGAK94LD5JonCI/aImrpjAvfZXWyVcjrHBjfP42yFEGIK4FSlle4fGF
         kFjepaycHDac8fwS1r7K5wVnodmrlk69D+uMqQD3XbM2b2P7mTypo4kC0hwNKO/W0ce5
         P+1+Df6V/BD7ZJ9VgepxsPmInmqpoCNL0fyp2/utKmtCITK8/cUHsIHZn6IFNlBJWbZX
         PKB5JwE3EqVmhZnoVatXq6ms1R2c140fXCFVm+XDQJ0PaoJGjItS5jAe1YfRRUyqg38r
         TIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119648; x=1793724448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RlopbpHsfSD/OHRLgQiY6wQ2MChlTJY7NnjiKCoORg=;
        b=B1K5O5TqRHwR40/jLw0RikmWtz2Sf1X7WH5TpumPqM4MW5OpJF8OAVhO0YMeVE0kEr
         6JQZU9fiOAhcVTuWWNjqflbDX7/hrLUhWjbHZWCI1h3SHA1m7xAjZCuX00q+8KJCoFmc
         BacwuYFRXeeb6bmXaVmT/VnLsLzW8qRbaKifKM7RUMZW6HWW8eN/aJPr6nkfgxiO1K5/
         hbsBQ29tYf3REPh4c98/WTtw6+DdGOWD3KAuiNY6TBMvRfT3rOTSVUa5AXwaPDLqmZAC
         21QJ5I+2M4T9b3ITi6Wg9pf7XCj4wNvXuf/mOlCxiAG4zZJwlpww+/yYaohO561Dny7I
         xApA==
X-Forwarded-Encrypted: i=1; AKwUvByCfRWENi8LXPDoeuftj0I0d1e8YL2ClSEVlWSlDK3fpZu9i+JMzbZVfG4tl+OYHXIbrqhWp4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYImRabRuISAwaahEh7Ekn/SbsJyXuo/8R0XiHXQ3x2QhqnBs08T
	cgBKtB/K7gepH5aZ5zxz5aUfZ2/7yS62y+F/FEx4Cw50OoJEfPaV256Z0C4Pfo6yvk7keDm/Rrl
	cxb11cbs0DXHbFTCx8WJBJ23AbHcD5E0oNcV14Jc/MIOE/rJKqaXjCe2RiVh0KD9dpG4VIFw3Y8
	yz3oaSev+lXpSrxCemP432gJrwt3Gn
X-Gm-Gg: AYBFou1dPJjrVXTfZ9E86DVt7mziEO7PiS9beB0Gq4ArBUnwzLZE/0UvNCRbKx+w/t2
	Yk49oYi0E49gm25m6xCN3IoRL3IK7bEbdJsfcrzJoUqFGUr8SR1q4MLKMMX+z6/HVhsTlyrpyVb
	YKGSTfdna/B82njMmf1w4aoOZOCWY5VYU5VjEgmWlGJJaOfxHIeyQMqmXJnpsFZTm2LuFS6AMG4
	advJpaOBBMefCXZoKptYOVtO42lxhDJCxZpnxdXafllUDLdRJFLfRj9cDNbE6b46tG6A/9xTGEC
	p6F/B0XhUAU+0+t6z6KBw4Uw3HiR0hliD4R3lg+0bPLPc8d1qR7p9bF+frfX
X-Received: by 2002:a05:6a21:610e:b0:3e2:7c10:d47a with SMTP id adf61e73a8af0-3e7bfa41045mr7510157637.15.1793119647856;
        Tue, 27 Oct 2026 09:47:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:610e:b0:3e2:7c10:d47a with SMTP id
 adf61e73a8af0-3e7bfa41045mr7510137637.15.1793119647432; Tue, 27 Oct 2026
 09:47:27 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-thpsplit-careful-v1-1-d357d70fd6f4@columbia.edu> <9620707e-59f3-4b91-87af-2b8e12fed260@kernel.org>
In-Reply-To: <9620707e-59f3-4b91-87af-2b8e12fed260@kernel.org>
From: Mani Tofigh <mt4022@columbia.edu>
Date: Tue, 27 Oct 2026 12:47:15 -0400
X-Gm-Features: AclHuK8gWWzzlKcn_L6a5T3j9EArAQHuwSjlQ0HWOR8CGZpOIEuzbTcpRfvDslE
Message-ID: <CAE2e9Owov22KK3ZPkfqwrJFpAMc_H5Qq22aoKpQ=0mWhiX5Q_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: fix deferred split list corruption on
 partial unmap
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tz2294@columbia.edu,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=K763jCWI c=1 sm=1 tr=0 ts=6ae0d5a0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22 a=VwQbUJbxAAAA:8
 a=nzbCeCAtSJT6Iwx4FrAA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2NSBTYWx0ZWRfX1CYsSJkFZuwS
 y2WaaAOBtzE57VmCo4ewtZXLrStX8vpsKJNx9GV5Nt13/iKna5c54rUlFsPy2l/AFTFkZ1JILeJ
 CL1eeh0OcOIQWXWx1q0neXkD+SPymFRXdqbdVS/+9Lyw4H/PaZwkvcJYFNipSdo0kQPxdQWluh/
 Dk+36BlDdBYLUXWoE7U5aOwRRy1/zr82Mj8RfOHEnMA1fawySsn2vzYuFa21vMUZcQn/RRuKI7+
 rBKmhNBI9YM3ZEMtT8vcCw3G/LixKuJ1ftsUC6MJM9ZWmo05WJ7PysjIpjIlrlQsF6ng3/q/NY5
 tJCedJ8u/hlif/090GIfihhGVMCeVIeMTmRSz8qklvowjwgav1dnPTGcGj1LkFBw6RrOm57ceEi
 jQ2jNTXIVTCXesryRimm1nWvrpMtJ0PjjP6bgmYiDvELD2yE+Y3Ec7eglIZ27gL4xPcl0C36m3a
 DdIEY8JIMaL5sBmVxsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2NSBTYWx0ZWRfX1HU8lgar645u
 /vc6ipaQBdnCIG7zbnvJ4jrz/u3GOa1kcker4T28xRTf0OGhTczNuvoC3aL6QgUzbhETw9o8wzW
 JGidCwoVYUDybgxZpgikjW1L5IX+2fSV50pMWTWflG91mpbI3/MR
X-Proofpoint-ORIG-GUID: 0Aiz85yEIVTjLf2Sdytyon_gqcZ1xg8L
X-Proofpoint-GUID: 0Aiz85yEIVTjLf2Sdytyon_gqcZ1xg8L
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11948
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=10 adultscore=0 bulkscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270065

Ouch, sorry about that, it was not intentional. I searched for similar repo=
rts a
couple of hours before posting, but missed yours since it went out about an=
 hour
before mine. Your version is actually the better fix (more on that in your
thread), so please drop this one.

Thanks,
Mani


On Tue, Oct 27, 2026 at 5:01=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 01:=E2=80=8A22, Mani Tofigh via B4 Relay wrote: > From: Mani =
Tofigh <mt4022@=E2=80=8Acolumbia.=E2=80=8Aedu> > > When a THP is partially =
unmapped while the deferred split shrinker is > scanning it, the deferred s=
plit list can end up corrupted.
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
>
> ZjQcmQRYFpfptBannerEnd
>
> On 10/27/26 01:22, Mani Tofigh via B4 Relay wrote:
> > From: Mani Tofigh <mt4022@columbia.edu>
> >
> > When a THP is partially unmapped while the deferred split shrinker is
> > scanning it, the deferred split list can end up corrupted.  With
> > CONFIG_DEBUG_LIST, freeing the folio later reports:
> >
> >   [  523.871401] list_del corruption. prev->next should be ffd40000005e=
0090, but was ffd4000000500090. (prev=3Dffd40000005e0090)
> >   [  523.871412] WARNING: lib/list_debug.c:62 at __list_del_entry_valid=
_or_report+0x177/0x220, CPU#0: thpsplit/63
> >   ...
> >   [  523.900715] Call Trace:
> >   [  523.901753]  __list_lru_del+0x5f/0x220
> >   [  523.902588]  __folio_unqueue_deferred_split+0x238/0x520
> >   ...
> >
> > Without CONFIG_DEBUG_LIST, the list is left pointing at the folio
> > after it has been freed.
> >
> > Since commit fafaeceb89a5 ("mm: switch deferred split shrinker to
> > list_lru"), deferred_split_scan() moves the folios it scans onto a
> > private list under the list_lru lock, drops the lock, and then removes
> > each folio from that list with list_del_init(), which sets
> > entry->next =3D entry and then entry->prev =3D entry.  Another task may
> > in the meantime partially unmap the same folio and call
> > deferred_split_folio(), which queues it only if list_empty() reports
> > it as not queued, and list_empty() reads only entry->next.  If that
> > happens between the two stores, the folio is queued again, and the
> > store to entry->prev that follows breaks the new link:
> >
> >   Task A (shrinker)                     Task B (partial unmap)
> >   -----------------                     ----------------------
> >   list_del_init(entry)
> >     entry->next =3D entry
> >                                         deferred_split_folio()
> >                                           list_empty(entry) is true
> >                                           list_add_tail(entry)
> >     entry->prev =3D entry
> >     /* overwrites the prev link that
> >        list_add_tail() just set */
> >
> > Use list_del_init_careful() instead.  It sets entry->prev first and
> > then entry->next with smp_store_release(), so once list_empty() sees
> > the entry as empty, the shrinker has finished writing to it.
> >
> > The reproducer repeatedly faults in THPs and partially unmaps them
> > while the deferred split shrinker, run through
> > /proc/sys/vm/drop_caches on the same CPU, is scanning them.  This bug
> > was found and replayed using a deterministic hypervisor currently
> > under development, but the non-deterministic C reproducer can
> > typically trigger it in the 10-500s time range.  With the fix, nothing
> > is triggered after 1800 seconds.
> >
> > Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
>
>
> Are we now sending alterantive fixes for anything already posted? :)
>
> https://urldefense.com/v3/__https://lore.kernel.org/r/20261027-fixes_core=
-v1-10-6f74bec9a5bb@kernel.org__;!!BDUfV1Et5lrpZQ!UY3X4w_grTd5b7xfCu9wwNwdk=
STttnBXOqxvYQg-6iGDIzSIewW3zRtTjNpV60Vszy5yvmUPwTRGqM6HMis$
>
> If there is a better way to handle it reply to fixes already posted.
>
> --
> Cheers,
>
> David
