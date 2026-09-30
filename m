Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85251DE18;
	Wed, 30 Sep 2026 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803482; cv=none; b=EmwcqlBmkJ74562FmPEpBt5CCzXCbM/s6XLEO9gLeSbv9hbsypX72ddLkC9ThENfkYXPYjhBANb05Qn8VHHfc7TQw8oKKsO2CMVcSypkjqQNjpJenxSfcpW8y+6FHo6Rtit37mb49jrGj7Mtq4hss9hE030ikXN+n0WXtc/S948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803482; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEYpCZ6X1/e1btUei91bYglG4LffEfedQAGK6qag0ULxo5GI2FLFacS7OUIx9SdxrLUVGNSeqUXTb7LVgyMANt41VrRhQ1JfMjKeHVm2Ipd+UGI1Ymh7SLqtpKsmUrl8qt2BtuLLkZ011xQB0XuGiX0eldazgV/M/65Ht2k+CyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9HiSN75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9HiSN75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F811F000FF;
	Wed, 30 Sep 2026 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803480;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O9HiSN755l1gITdHmGrwa9AJF6aNKMG4ArQyJqvfZKkLn5dy06NXL9vz+0s7xzFE6
	 g6OevAEIqmJUjVTufTB8r1Xg2LUb7Khs7SjKB41flxr0G46shrWifoUYUWY25DfLSR
	 oEmHuSGna+kEPM89Q24cahBvOwsAbZr/dQU8RUx/Wv+ab3QtTNGk4v5Y/yLAEHLINC
	 1N+IjjIP62Uykj2EO+z0oNEgq5MhVX2sDcOcAxoTmJij37BosPFZxjG5K7JBb0A0YY
	 aGmMqZW6DTXk0UesX0AwfrJDhoixsEco4BNAX0VWk0VcE3JgqaSCeIFFkyOET4wcu4
	 CwRelNhrX4SHw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: fix use-after-free in __tcf_action_put()
Date: Wed, 30 Sep 2026 21:24:39 +0000
Message-ID: <179080347976.31693.2610270473405626265@kernel.org>
In-Reply-To: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930211839.620410-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
