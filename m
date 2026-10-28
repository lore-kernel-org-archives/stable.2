Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225542;
	b=Ntwh8REfQjiPuwdqP2i4J7bkmMw+VfURaSYytqMBLU5Oq6ksDKe/biz2D5Ka1IK3BFk7
	 T7eyME7vGPMFKGJZI+pPKHbKTDiIVQMIPL+YRfSdD9tWWyRtkIRaG8YfhtQUkQWNmRvJY
	 U3Z29sDTYZK4WStEZEj9i2hHjhPBuf4v+TNLwV4a8/pLaWb4LMjWr233nUxWBbcKmvMlh
	 VRgl16jvEp9Oe2fhrfT41xtvzn8srhPCY6BtxGU68R3BDwJv5WvlqTRTmKSdishbvTRAW
	 vG9iFTCaAoc/vux+c0L8OMxWpU0ZPtQY3uLEVU7THuqkMLK06uU7mmJr6+/2oUDkuQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
	b=to9gyp89R5Fk7CDWhh9VA3XVJINwE6lRqSpXogJGvno02SYs4SZJk1nJqQHXHrh5K4OB
	 WDNnWusNJ4FskTt7bjiXR1uqoUshyZ9Zen6jJhz/SH5MOTTrbxAA96IW/Z18+6Ux9j/Bb
	 x6RELvBGw9WdS3p0geSPoJ6bAiC82f/tEUO6qAkr3B2ndTauCQj7+WOPSACsIPzj3U6iN
	 +zy70FYm3dY45pV4K4lTGbEdq8VBBgF3xohxA8qEOOf8XxW2gQNo9JlVif4pHoI1FnR+S
	 QTxVI76TCUzolNx4/gxahYnuvTy5SmFv/8B/920Gy23UruXw6MbqWHlUaySYP+2GoZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnkFbGfy;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D0606A31D
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 22:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 707D0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnkFbGfy
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso881155a12.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225542; x=1793830342; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
        b=xnkFbGfyThTA7sluMZxmZe/tFqpjJvZy3BeuOLed26PK8rowB56QV2cjDujQzKsnK5
         GmKOvl3lLNDF9C5LpnDrWNawxrKWoxxU70rlZ6iwYl0mxsIKQ3ly3Lill8mPGcXbrb4l
         eUX5LUBQiWAkI0dfYPxeTURpchTwdtOcDD+9FlP4DQFXuXf3UosexQz/ERHwO6vwz+Ra
         EU6Zrfns5SFmZ3fK7Drf1jdJHaZQHj2LozTBeFtqcK0uWlapx6tvjETJwJOym6hYNh4y
         u2VCalQu7IZ1Kd+AH+8oGmszIZmyIhJhleepD2SpasexA8HSFfh0mhOul5qFADVgwGkW
         bkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225542; x=1793830342;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
        b=yrQzvCACY7BIdDsvWP77E/VFbYgI0eIK6xRGBA2ZMtJeq0uRDct4WSubhFqMlYS4n4
         txsTPX5q4s0+RwSw12t8RJkhdE0F3KL/4xyQm2XvN6jSiFIevcgJPXTeWITNMJ+E93Ek
         irGhPj20/ybJc0QucTD1Qm2wnKYt7DVwJ88X+FgErXD9zGnt01W4YWZwAoel+L9JAO2t
         Ddksxz/lzgK+f3EXTFuXmXVxgBK55/H1aXNJGacxfaUtiiYhQrbD4OMG57EHISDLF+WW
         2fU7vfSqLG286N8uIpRTDvbPj0spg46jcHQ2InoQ025UlX2U9Hoxxw4/vGL/aUTyEnN0
         FS9w==
X-Forwarded-Encrypted: i=1; AKwUvBx8EP5K3q9sGAeJH6UvHNKJa/CA8gaT+hsFnaCtrh14SD6Qa+hbSm6mWgTdXr+N00Cq8AZ12P8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL85E/2cNJFCfSSSJgOFuP/uq0hz9ufr0rhmqBNJfCyndTfqhFA
	kX4G7PHr6VtnNihwCJMHqWJIA1a2wxgqrdyVrl/jQ05041mes9E5WY1H
X-Gm-Gg: AYBFou3Nn9cUn3ynQ1IizFkQ1OzDoBBkrN49tX/C9qcy+DGCjKvwOFxpThuHD4/mf7r
	3BvSz/TeMYbMWzoH57sYjA3drxjXuJm/P0keTpTmjfOyRAYsTgFYixlBYl8DkLCg90GPMkKG2Pu
	+iZ86LzSwMe8dTnwuf2ufMDQ64oXsr3csi46Tg6OtmTo/ejBqXFLyDpXioywuRUOY+CzSyG+nMD
	o6VYkN4/4WTrI2DSFhA3j9DGAmG/aVhtm9ekqqOYKo23L/1Efn1UuP2WMkaIsd0dV9GRA/myDTV
	StPGeSsu70KVwD7NnUP+ViA7p0sc8hrOVRfGrQbllvBDKQDbDymWUz4kICbt4rF5N7G80Lhw0si
	ejEQ7uJdyEvwiBOHvxXrTnaShkZ6NBVssheTuSA5GlwsIprxJ6yPVctoK80dKpmnfcRg8kV7UBo
	Mfi7Azca2q8tjcwxkb+QUnyFko0flCevrHu1DOaD1V1Vg5n/d6iDf4tgbRtcpLlBS1rwrPOyfrv
	CrkIfDfRkfIDnPPksjWdoIZywu6I07Bdy/XygOZVaSCGfq5G3hW+2mCqCwdNfnKjiHyPMychq86
	XzzI+pHCMVKgCGdjdAOQ/8Zbnlbgj21d5QM8GBtxp0dAtnDc0WJaXg9BoQFFT3leZNc6XOuvoUI
	DJE7vZcseK3Pc2fkGvTPivODmoV4k7FdThls=
X-Received: by 2002:a05:6a21:4c0f:b0:3e2:ac98:68ab with SMTP id adf61e73a8af0-3e90246ec1amr2827999637.54.1793225541650;
        Wed, 28 Oct 2026 15:12:21 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc8f97esm4400709a12.19.2026.10.28.15.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:12:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 22:12:20 +0000
Message-Id: <DMGTEGTLTEUX.HECMYVCWNFQA@gmail.com>
Cc: "Eric Dumazet" <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Willem de Bruijn" <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Manjunath Patil" <manjunath.b.patil@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
In-Reply-To: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
References: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 02:58 PM Manjunath Patil <manjunath.b.patil@oracle.com> wrote:
> Commit 5d39580f68e6 ("tcp: restrict SO_ATTACH_FILTER to priv users")
> requires CAP_NET_ADMIN to attach a classic BPF filter to a TCP socket.
> However, a caller can still attach an eBPF socket filter through
> SO_ATTACH_BPF without this capability. Both options install a filter
> that runs on incoming TCP packets.

Nack.
SO_ATTACH_FILTER takes insns that the caller wrote.
SO_ATTACH_BPF takes a prog FD, and BPF_PROG_LOAD is the gate for it.
unprivileged_bpf_disabled is 2 by default, so the load needs CAP_BPF.
An admin who sets it to 0 allows every user to load socket filters.

> Disabling unprivileged BPF loading does not close this gap: a caller
> that already holds a socket-filter program file descriptor can still
> use SO_ATTACH_BPF.

That's not a gap. The FD is the permission.
A process with CAP_BPF loads the prog and passes the FD to a process
without caps. See the comment in bpf_prog_load() and
commit c8644cd0efe7 ("bpf: refine kernel.unprivileged_bpf_disabled behaviour").
This patch breaks it. It also breaks a process that has CAP_BPF and
doesn't have CAP_NET_ADMIN.

pw-bot: cr
