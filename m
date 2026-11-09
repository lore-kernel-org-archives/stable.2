Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192103;
	b=FJWyuVfv2p60gUxCuDmbE4HGkxEfIVNj3d05Jr57Q2NKTAX2a1hGazGln4Cy4y2FEYii
	 fvWLjX6UP/supeE6EE+Bx36ZYSgkzdJmIc4JsVNNLnToGXjsXSwzuN/QIk5b80IoYZxsj
	 +3maj5rm5SeLzRjJJw/KhoHisvM66zH67sAWNQGH8iJJIng2mrWxoOcJR82rQPp7ApJm7
	 V2Qw5d7yNsBkiMzkHaAlY3ErrJdKRFkE4dXsTpvrQy2kXczpHLozJrvksGBIOi7h5yeX5
	 gmXM6dE/XbBq17440leiJLUWMoO7cssswRX3yeFXgcfYEtdZJF+wAVnXFyIB8/UEaFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192103;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7Oaet72IvSMtzXaUg0NEIECqrGi+MmFL4ZFRzLknTqI=;
	b=uXtDTnE/ZOXI5C8CHEyU2DrM41M+svyz1WUN+CQ2CRVrrX26Q//aQtzVUPIswrCE0kHF
	 LKCe7mzYNdP1nIm9n0QOhUZdB5bF2kKXoAfPZ6aXuDeE19sJkk+mtigl49KW3uPbLnuoM
	 SvfmMPA1iNVw8IhKYcg9SRTJWv9JjBrIFAXxW93bWrwDMrVP3UuaRyuLMmWcVpNqJvq4J
	 z3ODo/1WXgddL4kPD4/nSUrqOs/WKGgmvap+RNjVHxULQym3ZO+XxQs5FMQwWuOleMT3K
	 N8vStcO3bgPBXHgtNTkzA9lpC82NDcsBODKHsKCGk/I0Z/aeCoHHOPKfr03U2kvIUAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=rWOopgiE;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEF606A31C;
	Mon,  9 Nov 2026 02:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BBEF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=rWOopgiE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1794192097;
	bh=7Oaet72IvSMtzXaUg0NEIECqrGi+MmFL4ZFRzLknTqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rWOopgiEHK1q4WHZL/AlV2073gW+V3gZAMwMyxI8bxN7SXTNinr0gz8VCy9siesfk
	 ePzhUU/sypy1qy38nMn/97nOCZdZ63mAS1mXJvugb4JHBNfmrOa4jH7aTNquuvBJ7g
	 QDClkO3dKmLRgpXWFQ6sb4Cg5tRVfYIqpc8EKNU0=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.240])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id A628646A; Mon, 09 Nov 2026 10:41:34 +0800
X-QQ-mid: xmsmtpt1794192094tble5wlj5
Message-ID: <tencent_3455CE5C67BEF809176851A476321557E70A@qq.com>
X-QQ-XMAILINFO: MJf32pulH481VJxcL+chNSP4XMn7WwZ1fKHh5wH4lUPYryecSU5RCPxXI+qnk+
	 hJz3p9hMgYkOEkoW1egWyF8mnDd+ZsOJM642LwYBBrDlH6mUZvr/aiRP7Cup6AjPh1Hq8SIp/F0l
	 TNYLWAo1NTqkVpGLqckeNY46ZOm6PRz0ai8Qz6aNH/ag9oWptPELp5ponF6a7YJ4CfhRe68hHWUK
	 5MhD5x6v73AmCeuS4zw41zHkikdxWjeIc0h9m8UMsGyM/J1BcLnmKYfRtJcqTa8tcUHBbGWjpnG2
	 RD/6lAYstyLR+oHeAE7nKcO92cgHX7tSDvn/1Dkr+j7S6GZMI4lviFVspsvslU4WZiep5FScnzSN
	 xq3iFuIFdteC6jzUQVXkMzkN7HcDsvZpZ78raWbqMFrpARNPDD4jWB7kGlTIMlY/KEEKn/VYf+5U
	 IoVUDT5G85auvsHFZEEXIBMAVF6TNXb7Jrhsjo3mm+zBnmOLAQyuNwGgLkIVvjjsAHcTAzMXbWQF
	 CgJIz0xgBG02I9lZ2bYQ0WCI0zJqOTuJQLAdvAaTvg4a9O0NN8b6iGD2gpe7bDDvUY55+bAta/Cx
	 YlwUFLSwWoFoofe++9hptYRXnlhNJPOOP942vxpA2Tx88mDgJK8+XKcg7sdOHH9paLQSQrAHuDbJ
	 33ORYNkI3n7DGeaJ8fcndXL+McvqSvloGqHVyLTERolaYBHqWkZFW6ojnm8nRqnacvGpREtf54wK
	 z2db9a6Ds3QrNKAawXEe/50WiAzA8qcu3LmTVW7qm4JNWRMYPGazC4bGtGyEVou+zC54aP2tn8RZ
	 6PvV9tOJ7AMweUlIZCggn3pzSg+fjG3mU5rCPKI2O0TFEH7kV7rIMY8PWPIhF4qYBqBQYN6csb89
	 RDRUaTk/eTwWMe22eH48NlleFpyC+nvWzVeWs0nxd9jEfXKmhKqpUrKxkh6GXkFBX1HcnB2lBefn
	 uhgjHepZDVlD1OViMQhyOTinxryO2h5L3KytYdh+vyaZXKZ6uT9+V9985ACODeyN8TYmGFDVCwlT
	 G9UBLgkNEUHggaanInWikx32g4PsHnD0+fgYhBNfsJpUnrmbx65FmszsbefJs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: bo cao <treebacker@foxmail.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: check cpu_possible() in per-cpu helpers
Date: Mon,  9 Nov 2026 10:41:34 +0800
X-OQ-MSGID: <20261109024134.771-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com>
References: <CAEf4BzYDmzNoN-5Rnfj4RrAU8wKnZe+tDFApng61L0mubXqung@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> please trim the commit message down, it's way too verbose

Will do -- a trimmed version follows as v4.

> not sure this is right, bpf_per_cpu_ptr_proto specifies
>
>  .ret_type      = RET_PTR_TO_MEM_OR_BTF_ID | PTR_MAYBE_NULL | MEM_RDONLY,
>
> it already is marked as maybe_null

The proto is marked, but check_helper_call() drops the flag on the
path this hunk touches.  For BPF_FUNC_per_cpu_ptr with a percpu obj
argument (R1 tagged MEM_RCU), returns_cpu_specific_alloc_ptr is set,
and the return type is then assigned as:

	if (returns_cpu_specific_alloc_ptr) {
		regs[BPF_REG_0].type = PTR_TO_BTF_ID | MEM_ALLOC | MEM_RCU;
	} else {
		/* MEM_RDONLY may be carried from ret_flag, but it
		 * doesn't apply on PTR_TO_BTF_ID.  Fold it, otherwise ...
		 */
		ret_flag &= ~MEM_RDONLY;
		regs[BPF_REG_0].type = PTR_TO_BTF_ID | ret_flag;
	}

The cpu-specific branch does not carry ret_flag at all, so
PTR_MAYBE_NULL never reaches R0 there -- only the ksym path (the
else branch) keeps it.  Nothing after the switch re-adds the flag
for this case either: the code below only assigns an id when the
register type is already maybe-null, and clears the flag for
ptr-cast functions.

Since bpf_per_cpu_ptr() does return NULL for cpu >= nr_cpu_ids
(since 01cc55af9388), a program that calls it on a percpu obj and
writes through the result without the NULL test passes verification
and oopses on NULL + offset at run time.  The hunk carries
(ret_flag & PTR_MAYBE_NULL) into that branch, which only restores
what the proto already declares.

Thanks,
Bo Cao

