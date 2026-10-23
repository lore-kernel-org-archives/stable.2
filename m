Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792780709;
	b=o5ecuAypm7zVucSzEIR1jy9UDV29/U+tFYzP2NfPtAA5CMb4qIPx8emVvvy0zLBxIhSc
	 djPJk29uNtTBDVw5BFOz/sTc/BpcjSZAtKDmpguQkd6sS6MtsyZWorQH/jYJu+/xSP5VP
	 gabXhAITfUIsBWQpKS3jR7Do///IL0ZMoNBr5A9oiwDuYLjqkuw7aJSfz7J2kAVkZcCW9
	 NVzpyn80tgf+AnTanisoxHa0UmlJ736ZvITtkfyzzOhdOoCC5i/J1tIERnJb42M9Tb0D4
	 rV6Qz0y0pMgtmRImPFYR1rZZeCZcry9eDZFeWo+syNwRnR8WAxiImo0VvfX1oVg3iSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792780709;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=lCyBiYRSw9SkkQC2KbiCAFmq5F9fmUPyW/UopXiMXiI=;
	b=DxdGIeUN6tRWoYxEcK276P4YqOZmyZqb19HJBvWpQTD0P/U5jH+iwXfF8+2NMpO4dDr+
	 KKhMfsFInotGY7iKpcItiS9HskNop4UvqM7l5+JxRok1MbM2okkXcFSQVGc6chJI5Af6C
	 wX0BNhEA6QlNpEX6C4GqdgC3ImW7NOjtaE5nFUh4rKReKAP+7/4oJ/vGCBR2nbrAOHnx9
	 z21Y8U67yCJjjbB7U6x9hthUkpv5pmycynPsxi0jR25kCTR1bB3VhISGLyV48pf6K/FYg
	 mkFLr34jswzdQ0vDJP/sCZQcOaJpp2sXp4co5cWPbn2ULqtCtvQY0mzm18pjHcq8oCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=AnNmlcfT;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD2606A31A;
	Fri, 23 Oct 2026 18:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BD2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=AnNmlcfT
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id AC71C1C240B;
	Fri, 23 Oct 2026 18:38:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id DBED930;
	Fri, 23 Oct 2026 18:38:17 +0000 (UTC)
Date: Fri, 23 Oct 2026 14:38:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
Message-ID: <20261023143816.48163575@gandalf.local.home>
In-Reply-To: <CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
	<20261021174406.2891598-2-vineet.gupta@linux.dev>
	<CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7qkkh75ignt3qewezis49ixkcgfhde8m
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: DBED930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+nNobuDoV7+6C+HwMufpBMVCxpRn3jLXo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lCyBiYRSw9SkkQC2KbiCAFmq5F9fmUPyW/UopXiMXiI=; b=AnNmlcfTGob/L9YI6qPr8w5mvroGj0tlirC5etc7sp0u5SlTEEpNvehTPR/UJtV0U+a2x804gqc7Rje9ArBnNHY5b0iCAs22aBgg177J+PCINRpdtnCs1m72t9G9aLCrLkcfHrw9eD1itRjjzEQ/NuCmIdmTliemRb4iN7PjvJA=
X-HE-Tag: 1792780697-920593
X-HE-Meta: U2FsdGVkX1+PteRbXq2UIOK+GAECd5Q0Wx9sa6R2UvKrl09WwahqwOMj4yNTck+A8TIF3idbEVsy3rZJqMsQrlnD9LWFIvWlAdT/xu4gfjL3ChGmACTjrCEyClIHtzUCPIUekI52BZqOp3ZlufK3FRVZg/sdNWRFYH3Y4ZTPbmiK5Y49ULZmd6G0kFLgTQiZRnuD9Mkqp3QxeH/+upYagkETu19JniqmahR+98laPl+QBlkVo1ZDSPLdv7pQMDsMz9pkSazQHyX4M0qdIdeTeSTV/wgM7Z528boEhYKP9VmJz0RclWdmEReuG7ZWqhOFK6Kgcp3uR+LJS3rbiGef32Qhb7IkWRqA6Z6CfI1rQHvswZd5CXqilg==

On Fri, 23 Oct 2026 11:13:44 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> I presume this will go through Masami and Steven's tree, is that right?

Yes, but it came in during the merge window, and since it's just a speed up
and not fixing something that's broken, I was going to let this go in the
next merge window. I rather have a change like this sit through a full -rc
release.

-- Steve
