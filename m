Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363456;
	b=cpPdAM1MitUX1Qhk5g6f1JYIzHhk+yZ6bvvqK/vQ03rYwIc+tdYCQSywOa5n50/mkCB0
	 RINJ4IjeB5gqIJMVbtO1jRyjWBGogf7rpUfXsIWSiN91iEb6T8h0Iq66tY5ndqGE4mghW
	 t38BJDDnxMuf+tiMLUAXCgDhe8gyO7TAQHWQXqrOcfkyz6sNCV/LjIwgNTVAmjIfQ2+U+
	 zYms5ct+Kk7+IELAtjNvjPiHQKsfr5mbo7bEjFjLHg8sVVhgUfoaSViGYnPmaXPRMMzW6
	 4YrpdQr4rWsP9G293dvEfgaU2b3/dgTfQnzTnfLl03aTBhDH+gyf1h8b6DP1WTeh+Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363456;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ou8BeWUHXvm1do1tafv+FgpDXtR03FmpOLYVhh2n2bM=;
	b=sG892WWMpMhRCzNk9Ht5R+GhjjanRWt/6yK8GQO2F+kFtbeGzs9xUs6Y0+ODE45o/pZU
	 rojIKRlOs4d6O3/CPlFTx2wgO9MATsj9XTYQqgQWUcQG7HF/UJrndiAZVCUxWvKrjVZup
	 7UD43SkKbYyYYfYAEBjGMYcLhlFF/1tvzSTRdyiWaOHGovQdwFOJ+U6N4wVRjgy7D7xk4
	 Fpb6RUnvw7VW8dXEfyVRGEMEvO2eE9L2OQID+NBpNJyltFx0CMIiNatuZsw4EVIN0b37O
	 5i1s6oaGHh7kmvDvstip9GC86idRnQxDMaTWY7fRDMqN42D13W7wWzsoGnKtlHLD1jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TaJYx5ZK;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BB606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89BB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TaJYx5ZK
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cde827b7b95so228951a12.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795363455; x=1795968255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ou8BeWUHXvm1do1tafv+FgpDXtR03FmpOLYVhh2n2bM=;
        b=TaJYx5ZKDYy8tIOTxGfnZWxRbwPTCBGsMkQEi5TbkX+JGxeM2KnEWaPwFSzMgS0YY3
         +1fuR0XM64T5E4rH4iM/HNowVvDvPjANxp8V0JYVCHoIUICqn4WEULxh8OHfoMSivMwV
         SwTJWGbphviOns59teupF0DbQWyHxA0FZtblLTExmEInYPZN9V3wusgJjU7evLuOFChs
         q2E4m6qX92ZjC39SJyAOE4Jn5mbZkIhq6L8tngglBqw2K5ykkRDOs5uwHVrNWIPdKeqJ
         GaXBrK8N05KQ7bWo8dNB6lLMnHKRrcjEsoFFvCjPfUoKUPR/6khzTYD2n9YvtMUxzHzD
         2P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795363455; x=1795968255;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ou8BeWUHXvm1do1tafv+FgpDXtR03FmpOLYVhh2n2bM=;
        b=eX08SRKIiYKdF4WwEQYAKtWfr6EUHU/MUaBhTI8Y1RRDcosyq37ineMDxPPoXzigyL
         C/5dfeZ3Kx13PkwfTWD36mWaYdRnUNrpTpXBJ++jZG0kkysCEwoyFQRwIIJnLzKkJzV3
         rApsd2GLE6gZoHQNYZY9Zbr1dQiDLcX18NYYwTI64B5xpXgc/zt6H1kpm189zhVC+3u8
         E++FSApzWLd1hOLIIX/n4d5dVJOr5x9s5Q3sz6c5JxlUSAORyZY+zcG9s4NjZxsBPO3n
         iQLIyRrU586AI/Ph98FDw6yZTXQk6gVGEaaeMpiGX5UsuWfK5dzh6RNo+cBWJvlMO0Fj
         CZuA==
X-Forwarded-Encrypted: i=1; AL+hErF5I/SQT3robyhnHkK15g1dOGJUBny531q4FMCV7EKfydsDG3CDkPye57E3ExDn+EhxFkuhdyo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jul4gvRwMVUYLU+WdmkdKVMmOsZ4xtVQlqS9S/B8FjTH2bVqU
	GYph72mwYSckjJK8PQkuYw+eV7Yu6xtDdhbiCyPDy6Y5QmBimOmJqxQ0
X-Gm-Gg: AZFdTZcAjUyg0LV73cEo887YL2+Ri4MAdONYTIYnhmBPDiPyOOwGuxDbbM1czmzjWLd
	gflIWGs5jgkf+qJljZuzRLnHLGxW+AHqI+XibnGc3b9+r9Dlzp53wBv2MXqKAoBaa73Su8eV2M4
	UPiv9pJ5rKXaAZqAwJxA/jXPccOtNXWsnKb99f+q1sz6VbKPuAG8Gty1ZCOjzgnOHPSJW61hh1m
	2pPAR5IctxTCzT2r+mKSJVzVW0AE6iyCjxg/IRWGjJBWaDsymsi7AYwckuBLzx/UzzyBfdsBW5f
	u2lf0Ud2lZw5w8IixZF4nbxwKlpbo9VwTO35/MFKD+qua4YhKC7vX5iKAdoGiaII+XrrUswww4K
	oXCX3RrlY1Cz1xYTNYvSHcoUv95I93gIzGe6o14Ah1O6wihRbma1ETwIfx9R8r0X1lxc21Q/iQ2
	ikhPAccwcHykPWp3iZPJEe0d5ZEIrVhTe5oiqkO6JijmPEt2uRJ6iUukoi8sAIT0URu7zQuAl0X
	NuRS4STRS3H9XqySLN1jZNTLuzE6iwt0VSNkH233SHv9354+xQAr7wtyoUafOyTd3qeYz4dtjHj
	el9ZpJ/YmRaSBoYgOBvIzGjW9u9eNRXCdOLkFwt4F3A=
X-Received: by 2002:a17:90b:2792:b0:3a4:ca46:840f with SMTP id 98e67ed59e1d1-3b41c8e172amr7860609a91.8.1795363454993;
        Sun, 22 Nov 2026 08:04:14 -0800 (PST)
Received: from ?IPV6:2601:600:a482:7d70::4d5e? ([2601:600:a482:7d70::4d5e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41aab4729sm13183188a91.0.2026.11.22.08.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 08:04:14 -0800 (PST)
Message-ID: <4efdab67-e219-47b3-a94b-52119cb1da65@gmail.com>
Date: Sun, 22 Nov 2026 08:04:13 -0800
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
Subject: Re: [PATCH net] net: wwan: iosm: always send the host sleep message
 on suspend
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 m.chetan.kumar@linux.intel.com, mail@maciej.szmigiero.name,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261122050039.861287-1-davidlwesten@gmail.com>
 <CAFEp6-0_5YwOz6DiRKi_mNn2fCg7rJvYGYjOrVd903wdKZwCHQ@mail.gmail.com>
Content-Language: en-US
From: David Westen <davidlwesten@gmail.com>
Autocrypt: addr=davidlwesten@gmail.com; keydata=
 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
In-Reply-To: <CAFEp6-0_5YwOz6DiRKi_mNn2fCg7rJvYGYjOrVd903wdKZwCHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Loic,

Thanks for the review.

On 11/22/26 7:05 AM, Loic Poulain wrote:
> I don't find the commit message particularly clear, as I understand
> it, this change effectively ignores d3l2_support and always uses the
> host sleep message path, so could you please simplify the commit
> message and more directly explain the problem, its impact, why the
> d3l2_support distinction is no longer valid, and how this change fixes
> it?
Will do in v2.
> -       switch (ipc_pcie->d3l2_support) {
> -       case IPC_PCIE_D0L12:
> -               ipc_pcie_suspend_s2idle(ipc_pcie);
> So ipc_pcie_resume_s2idle function becomes dead code?
Yes, with this change nothing calls the D0L12 doorbell path any more.
In v2 I'll remove it along with the BIOS RTD3 read, d3l2_support and
the suspend flag only that path used.

I'll wait for the AI review before sending v2.

pw-bot: changes-requested
