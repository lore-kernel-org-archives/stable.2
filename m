Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3E12FD69A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791779869; cv=none; b=N/Gl9KSOA+OeYANamEgvJWa0eEbVi/z9vMGFa94ZBTKm6wC10XAYDOl5YTEJstpu1RLeCch1nXTbk8RzT1BOQv0zovSf3up16hG8/xJUdr3OOsXI4+1wQgslu6s9QslR7/gBslGWJLe1KpRtIj/1j9V6SYUA0I+AuYh1Jht82tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791779869; c=relaxed/simple;
	bh=9L3tqcVuwWT1lsikokZ8qkn9K8zI6RiafRhNL20/m3g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=P8zNTz8Mt3ufPCSpWaJk2B9aFgPjV0Q4J/KbsC0alYFESh2BqWLIf+OCvL5dBdN5ydlwftvK6gGbCiF+955O583QdPmZ0fSN7rACf4ej6ReJCaZzGSmeiHtIvqasT+DOPJVOyXnOaR+nPUzgc82vMIfw8pFbSScufcn9T/Nt04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBOWAIhN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBOWAIhN"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-88c72646f03so625593b3a.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791779867; x=1792384667; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9L3tqcVuwWT1lsikokZ8qkn9K8zI6RiafRhNL20/m3g=;
        b=cBOWAIhNKKr0horrqDLF0oKX0DV/YZBB6l2A5kd543PLVYabo406OV+3X61XPZGii0
         /VGhn6wgoIgCNMfNBu2Ohclx7AWVh73yIsxHBApXVKAp7vVSrHmu9JCPnvVDRshIXzht
         7qd1bg19lPI/Bl74ryDn59jT1e5IarUgEb+QC/2RwreB9J95ubAubKddGJzq0l/z8/70
         9hJefnubUZK9lMLOE5vwZoK1yks05NF0eSyzrVVhlhjg1g+j76k/+KONtwje4+Qal2L1
         Ud8n8PohZ2kI4n4LeKPtKethXkkhdapDwcMiLRfzy/Zf5Uzkj/2+sI1DXpMivCpgx+za
         eI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791779867; x=1792384667;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:content-type:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9L3tqcVuwWT1lsikokZ8qkn9K8zI6RiafRhNL20/m3g=;
        b=1s25SM2SStONexO/QUycYpxpNEuaSlewpRu6y3HWuI+HNpEqpeBtnvPVFXcU50zN+s
         BtUBD5CYbMTvt2kZ4dQZSYQds3sJqJye51Iww1R15NfZYpaSFnpVwLy+ZKWVJnN8rclu
         7vv2NidgEFM5rh0TLuDtqqDEYz4rShO8hxV6JQB6xyaXxnieM2vQNKRI9sWp++YyJqq5
         U6Im/ikY9r7HsWxwCgZt0dQ9Y1CCMpAuq/g0NGo843K3fu21Scm8l6hpF0N6HiJRVjZT
         u+duhHVacxoYnSxrJWYgaqKO3CQCJYaFBGTeWlQvERzFZqiUdnVF2E+xLbIwW+Zue7Tz
         9NWg==
X-Forwarded-Encrypted: i=1; AKwUvBybH6LrWJVA08xDW4zSYoQpt/jaXXI4dKy4MqGqXLBOMOv1PBej5TG+jlUKYX8jz62PGb8YY/g=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+fcFvnK/FsXV/bAdvxTQR9wxoms8sojXIJlVxiqNn9cZ5zZIs
	rgSyyoFKPHLlx1ptn2psR5jXyTBrHriC2XKGPKBkhCyGJYMG3y4jQmhM
X-Gm-Gg: AYBFou36tacEpT3OMkWKEjwUM9RU0X5N+iCVbX4IDTDmkUCm7C+ps4ztS/cHEpY1Cnm
	1K+Ur1sr3JSUcNqNFEtPmaADIjmmx9D5O/UWdPRHHLLptgcKQ/us+ER1tj5eHqpvW5A7p1Wjl7X
	4F9Sr8imGkRn/Q/zT/pNFtlYABG/axCX9Zc9n+pMBqb36fmX78Mt+aAbuTb1iT4R6RpRv0evWtp
	oXNldwT+SIj4WjA0myIJ4pnjN05YdJG3bKNmOS1OHBxeM7yX6GqnNhfshwM4499OQ2l6As/ai6J
	p9Z6YFmp6LBdmYavE33PGwzG5hoxkr1A1IAEfrhwLt79n+B8qqNTSuUQmQcgXFzxv7WUwBbjxS8
	qpiH8hrisi/gYJU+Rn5UOADBz/45128YBSMBT9i1p1JhHhx/SmrVjd7X1njifqV46RpMakN+5gE
	w3qQmiCKU19Pan1AAOTkyIitXlSfa2i94MuRsMe5nODKU/Xm/GQ6N08TUTC8O4+JOeWrUWjLQ=
X-Received: by 2002:a05:6a21:4598:b0:3dd:a195:fa1d with SMTP id adf61e73a8af0-3e16bf3fbbemr6620405637.66.1791779867370;
        Sun, 11 Oct 2026 21:37:47 -0700 (PDT)
Received: from [127.0.0.1] ([116.98.134.138])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da05caaesm3704308a12.32.2026.10.11.21.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:37:46 -0700 (PDT)
Message-ID: <6acc641a.d3162159.e3fd8.3a5c@mx.google.com>
Date: Sun, 11 Oct 2026 21:37:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Bui Viet Dung <dungvn2345@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: stephen@networkplumber.org, jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net/sched: sch_netem: prevent packet length underflow with negative overhead
In-Reply-To: <179177924024.434549.1159457377130534867@kernel.org>
References: <20261008035656.330667-1-dungvn2345@gmail.com> <179177924024.434549.1159457377130534867@kernel.org>

SGksCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuIFRoZSBwb2ludHMgYXJlIHZhbGlkLiBJIHdpbGwg
Zml4IHRoZSBzMzIgY2FzdGluZwppc3N1ZSwgdXNlIG11bF91NjRfdTY0X2Rpdl91NjQoKSB0byBw
cmV2ZW50IHU2NCBtdWx0aXBsaWNhdGlvbiBvdmVyZmxvdywKYW5kIHJlZmluZSB0aGUgY29tbWl0
IGRlc2NyaXB0aW9uIGluIHYyLgoKcHctYm90OiBjcgo=
