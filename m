Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658907;
	b=iK7/mPKLEc3yWZVfp5WlhcXze7vNW6+voAPC13pZpyVMxs7a1q+/uOnVPEfIlRKJTxN5
	 ZUoGNlS7RjZBYhUcee9Da85sf0FvIxSw4eCoFQrMQsdP8+mqg3cAY72+2/1K5MLvvmrrV
	 3mZ6ZJVAKxxahpNu8vA74/Jj15aA0z2lTEHiSbVtsRb6skGg64ASn9k2urP4Hn4VonzVt
	 kieROLULVNjyEZ6QRZc0/kNLJ5LqzHuiFmRYtNWdEqqZOzOgdNqtM39Nt00CxDtaopqVu
	 QQSSlpS3FgjxS6MVjk2oYB1lWKmz/FkfvQahuTpBZxZYYgi/wTsSWOMUj1Uuemj087Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658907;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=nySh5y0liynVsY0bHng3Wlzu90DnKeR+CEn9IJgSdwE=;
	b=f0Hs9EjAYPFnrAACDCIfewDMxOBxODngahWUadtPOVBOzTyB3uXfPBKGSvlyLebn92Kb
	 N8O/v/WD8NZV+/wQZ/SsBTurFLONHorjvNzrjQl3yh2YE0n0z2fE1G53olnPIF9gWr0iJ
	 GnsHQvVmMe4Bcx0ljkHZv5Keh8P78UP6bDworETdiaI3pndfckyu/eJ17mUVFSgCFfZPl
	 SGCzhzd0rc/4CPHdMDxMomYaMMIy85OiT3bjs1ntM7vIHnPRLgfDFtwaRtvT1JGtkZBiU
	 +yu1QxBbkNJHBNWOTV4o7yDt3wACD3KprWSQqRxbgrIURGqdk77LBeOqCpPqQC4ygSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B477C606D822;
	Mon,  2 Nov 2026 22:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B477C606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nySh5y0liynVsY0bHng3Wlzu90DnKeR+CEn9IJgSdwE=; b=onnHTcC35wt01xG4RX2AX4bQQC
	56Az6rX3rN2FWWbLOZW58qtZRPZxmtopQI+lSPbUQud4ct7syXI1X4xZnmIPn0uIcIlFwd1JL/iTb
	lButy6YaMp7TOzBy6HIDtIGxVIxE0qPy5H39La4m+vP83MqJasCtXb34rbYP4iBLt6rh0pirzoOmC
	cDrNp+FD6mAjFyS8NT8iezeO1h0TXDNJIDq93JxvK6L+1qC/JbZPqoisNllG0u7frytwEa/dOlmN3
	+6KtA5xcSYiEwAWovoabfAiXuJdyj8NiY6MxON0aU+ZM+dXhk74d6GK2rTZVkXq6+7TB6KOSmUiz/
	qjohC9Bg==;
Received: from [::1] (port=53530 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xO0cJ-00000009Lic-40Sh;
	Mon, 02 Nov 2026 23:35:03 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 02 Nov 2026 23:35:03 +0100
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] bpf: netns: require CAP_NET_ADMIN for link targets
In-Reply-To: <DML2GFI6LWXU.3ODKDXNQDBYYA@gmail.com>
References: <20261102202922.2515317-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <DML2GFI6LWXU.3ODKDXNQDBYYA@gmail.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <d984ed03fbd7b6c12b88f1a18d7762f6@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-11-02 23:08, Alexei Starovoitov wrote:
> On Mon, Nov 02, 2026 at 12:29 PM Jérémy Jean 
> <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>> BPF tokens allow a process to load BPF programs using CAP_NET_ADMIN in
>> a userns, however, netns_bpf_link_create() does not check for
>> CAP_NET_ADMIN in the target netns. Consequently, a token can be used
>> to attach a BPF program to a netns it does not control.
> 
> That's not a gap. The prog FD and the netns FD are the permission.
> 
> pw-bot: cr

Thanks for the reply, yet I feel that I misunderstood something.
At first, it seemed to me that there was a security boundary issue,
but digging more with your feedback and Sashiko's one, I believe I was 
wrong,
that there is no issue and that this patch should instead simply be 
dropped.
Am I right? Or do you believe that there are still things to fix?

Regards,
Jérémy
