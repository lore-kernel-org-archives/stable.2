Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391D411A1E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340972; cv=none; b=qk+sDD5RmcjympERONPknXmhyME+wIdMIj/eyQ4AL3ggDXY3lSgfwnGRGRE3OZaHAF4XeQghxo0KH7ZMoncIYz/Ckecp4IbRUiO+d7qO4oY5zAtZ0PNI2gnXsN+7kch9+V259kcheoXdeWq4zzpEr7O+dvBEsm3WArVwEjmkjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340972; c=relaxed/simple;
	bh=HBo82KCSUGdmfLmw+XjkjGQ3vVLAwAp/lLnwHsyPBn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCeLHyyTwUz+YESbTLRoPioBtgvJVQSBuPJJXBAYxR5FFdTemztU3dHIbf8StWvqN8XeToxb/53e2vby9MFE9PjoqPuDBgrpJEWQwgf87e9QDACHnDLRxJguB2kErjD3ZkOrtrhnCmHo2lwoD11CyQpvPMjjaw9eaS/ac6qIpic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6gZptb0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6gZptb0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785340969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+wsHGBgw5K19naIhGYr3W/foVErV3j2PeWPVr+UF1c=;
	b=D6gZptb0UiiiVyCxXUzoxFVO2LaJd2yzK8Ie9tbHi3vnzkEvpeO0fE4aIVX+5MtxmdtLuf
	zJntmjFsGA6AzDIeaY+suKdb17OkGk6VJMeTsCGXTsSNuqQBXU2k+elefHyLcnwCuk3yiv
	PjbJxrOZpDkap33MYPcBd5GzZdsBnyM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-ZZiDhcJDM1ieTJmFYB9W_g-1; Wed,
 29 Jul 2026 12:02:46 -0400
X-MC-Unique: ZZiDhcJDM1ieTJmFYB9W_g-1
X-Mimecast-MFC-AGG-ID: ZZiDhcJDM1ieTJmFYB9W_g_1785340963
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87BA319560A6;
	Wed, 29 Jul 2026 16:02:42 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CAA26180044F;
	Wed, 29 Jul 2026 16:02:36 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 29 Jul 2026 18:02:42 +0200 (CEST)
Date: Wed, 29 Jul 2026 18:02:35 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
Message-ID: <amokG13tEnA7VVVf@redhat.com>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-uprobe-v1-1-61896b87c867@debian.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 07/29, Breno Leitao wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
>  		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
>  			/* We won the race, we are the ones to unlock SRCU */
>  			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
> -			return get ? get_uprobe(uprobe) : uprobe;
> +			return get && uprobe ? get_uprobe(uprobe) : uprobe;

Well, looks "obviously correct". At least the current code is obviously
wrong, it even checks uprobe != NULL 3 lines above.

Andrii ?

Acked-by: Oleg Nesterov <oleg@redhat.com>


