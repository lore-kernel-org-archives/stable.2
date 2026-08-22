Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FA1DDC37;
	Sat, 22 Aug 2026 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428608; cv=none; b=uIincHlLo+Q+2FVzz5s7xHyp5f3487NUXiEscDmxZB11oXDucZCzq/Z57WLImVD/ny6w4mx1KdXmPFM46ZKpwtUieF4TIEOYxhGEEIJWCFlvmqxTA49o1BcIk6CwLCrZ4PQRyqKzhvLHJyVp0ePH+R7sRAh9CFlG36ExVSot5e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428608; c=relaxed/simple;
	bh=xc96eUAoBeu9NpnSs1o5PKl8/7jeSXF5K/bTAY4QuTw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=U4apyWE3RgT/lwQpbKG2MWGvF6PiMtf5tuFrRIOycyIl/3SjuEVwxwTdGCzx62NYRt65wsOB1kbKRS0DTCtdp8kYkvvjeACTHy+zU5Ld/apIaFVJ/+msZf1Ikb9sesKuoUH+ljkeJCnM0qcE1efbS6zrcs/xvoyt0v/6oqxUxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=XLYnl1nv; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="XLYnl1nv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UGyAzcejuZn6RAjVa/a1UNl3aOmLKX5vj1xgrjkiRNA=; b=XLYnl1nv6UUUvlELTQeZvW4pui
	DMX01V18BZs9ybR4JQXvUV+CyznC7C/NdNbXuLElV5Az0CbGzp1kZ2B9W+wzj2Ns3yhOHeDXH9t1v
	sBiSsQJmx8nsERV/QO4pVlrMLExageAKF/QIIoKhQJtwy4F2Cw+/Y8YuSmg/5BEJphF/3vudK+j3P
	wzTe2uc3L09j01V7KbfT1kYowLCd+HyfyaKDEq7C9qSUtslrSguNpD4l3L+hiTV6qd5n5NCyNUElu
	9Q1u83rQkquN+Vtott5JLxKhM8Iphw088YAibCrYorlHDrta+nS8WBv3kq22WVGrfo5GBOSnhyxFg
	3pRbi6cg==;
Received: from [::1] (port=48334 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.99.5)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1wxrpe-00000001M0l-1Mi8;
	Sat, 22 Aug 2026 21:56:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Aug 2026 21:56:44 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de, include@grrlz.net,
 bsegall@google.com, dietmar.eggemann@arm.com, kees@kernel.org,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 vschneid@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] fork: initialize function graph state before
 copy_exec_state()
In-Reply-To: <20260822112248.1b7e1b1d@fedora>
References: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260822112248.1b7e1b1d@fedora>
User-Agent: Roundcube Webmail/1.6.18
Message-ID: <7ca3c3808b2820d058b147aca6be92f3@oss.cyber.gouv.fr>
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

On 2026-08-22 17:22, Steven Rostedt wrote:
> On Sat, 22 Aug 2026 08:49:27 +0000
> Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
> 
>> dup_task_struct() copies the parent's task_struct, including 
>> ret_stack.
>> ftrace_graph_init_task() clears the copied function graph state, but 
>> it
>> currently runs after copy_exec_state().
>> 
>> For non-CLONE_VM forks, copy_exec_state() allocates a new 
>> task_exec_state.
>> If that allocation fails, copy_process() reaches bad_fork_free and
>> free_task() calls ftrace_graph_exit_task(). Since the child still 
>> carries
>> the parent's ret_stack pointer, the unwind frees the parent's active
>> function graph return stack. The parent subsequently accesses freed 
>> memory
>> from function_graph_enter_regs().
>> 
> 
> As this effects function_graph tracing, please resend and Cc:
> linux-trace-kernel@vger.kernel.org so that it gets to the proper
> patchwork. It will need to go through my tree so that it gets the
> proper testing.

Hello Steve,

Done. Thanks for the feedback.
Let me know if I can help more.

Regards,
Jérémy
