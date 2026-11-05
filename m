Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854096;
	b=ZBJZg5FZhbwMqZFbK4aiwPsyT4x0ku4UEbiH1FIkLSZuZGRfaSY8aR7/Ou1DoGcyhc4B
	 1IQnwhCd4Vgb7E9LK2Qn9NLaF5BHrDmu/Q355GLgj3yQ2ESWOPrRoj2AnsniSHNSWo33Q
	 FHGWz2M3aUz+88KE3SJ7wLlAsqCoAUdhgJw639Ts+RdJ9N7Z+UH8YgUVFQcqzy3wvWtPd
	 fnyweVrXcLNuZPycJD4zpkKBEt0q7Ev0nfj+p6g+eOt9pMBRvnbFGfiYybZ7QKkLg4oIt
	 SWqP40NvzGHKXc2xglGytRONdS3KKC0ycbvh5dxaASzAp+FiJ1c0GXOwfOCK3WhL0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854096;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ajZPwFVzN830Y+IPPsz+0JezqAnRFXAuGFeEvLV37Dc=;
	b=0reXu2gjvKuOH+qEKUwXWlIKVQjQglbymRe8xEEzlja8oj1hiJgROmqcYwaLbnvavp8j
	 AYdgWhFMquA01QyX7MUsGXi6Zmtk+DEM3JLwU4M1VbEJ50vWsYUBr3thOSv3wlg7Zchq1
	 GrXMHJSDrI79Zi21aEclbSSm9aPwOs99kLwuOQ5PqROZ1xrXhQNZ3s+lWzQXFUv0+Up5N
	 MynE85QkqBQoJ7GEbHTb3RVEQ1BY9d0RCP9ZaeRmbOu5oYrv4GmP1r8WBhGvr8Z9rSmgJ
	 DZpMZpWQsOeo6I1eOQA8BXuH9xm9E4AskWVJv+FWRSI5rUmfHyTdq3GPSRXBLjsYBYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dszmkarj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D8606A326;
	Thu,  5 Nov 2026 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dszmkarj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A302F1F00919;
	Thu,  5 Nov 2026 04:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854095;
	bh=ajZPwFVzN830Y+IPPsz+0JezqAnRFXAuGFeEvLV37Dc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dszmkarjYufbSUsjZvExyyUp/ZDL2EvsCN+bSF9Mb/PO6o07gIcpBDWQsgQ/tk+Mc
	 3nSzOeTS5JyCttdqKWoyIFs3afhglZIOuWmVTaeJIbxDcvuT9QUKEjLetq6RtORiTI
	 X8JMWZt2onC5Z2NfV0f/mAffSF1ktXxxhIGPk9mjLe+AGI0Z54z1oKG1iBrwGtvNR8
	 bzWgb8jUC1QDzXLeh4sSfhqKaP4Mka1S9FdMsHw1nYkMr6R6DQt55CC7tYGBYL6/I2
	 LVqRgzJf7PPyZAiT+JMPDpNb5XZRDs4iVfcZb64WFW8f0PGwtl6EDSMA0f1pbPnH8x
	 r8pmP+20UBkaQ==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] kbuild: Makefile.lib: fix offsets generation with
 debug info
From: Nathan Chancellor <nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261026074733.11777-1-d.kandybka@gmail.com>
References: <20260928105330.25427-1-d.kandybka@gmail.com>
 <20261015210149.78470-1-d.kandybka@gmail.com>
 <20261026074733.11777-1-d.kandybka@gmail.com>
Date: Wed, 04 Nov 2026 21:48:00 -0700
Message-Id: <179385408066.826739.6575864914757012196.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Q/Og4CeqvsVSOybsczxrTVCOHwDIbbWQniM0T9BChsA=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFlvuLqr7dlvPmt/E3d7IvPTowuv/ZgziTd0Uu5Mz7V3f
 Q3bg5aKd5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJ9E9nZPizmXWH/KXyv+5P
 XvvsTblaPdtI8XPs0qjn6mEWuy0Psl9gZNity7fj1432jYv1+s5YznIpeVFwfMO/vonMN+a0qn9
 6k8sCAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

> When debug information is enabled (e.g. -ggdb3), the assembler
> output file (e.g. kernel/sched/rq-offsets.s) contains additional
> directives such as .ascii with offset info and debug metadata.
> 
> For example:
> 
>    .ascii "->RQ_nr_pinned $3048 offsetof(struct rq, nr_pinned)"  #
>    ...
>    .ascii "->func); __data = (it_func_ptr)->data; ((void(*)(void *, pro"
> 
> The current sed-offsets macro uses [^ ]* to match constant names,
> which is too permissive and can match unexpected characters when
> debug directives are present. Additionally, the fallback command
> 's:->::; p;' strips '->' from any unmatched line and prints it,
> which causes debug metadata to leak into the generated header
> file (include/generated/rq-offsets.h), breaking the build.
> 
> Replace [^ ]* with [[:alnum:]_]* to match only valid C identifiers,
> and remove the fallback 's:->::' command so that only successfully
> transformed lines are emitted into the generated header.
> 
> v2:
> - Add BLANK() macro for better readability of generated headers
> (suggested by Nathan Chancellor).
> v3:
> - Check for ->BLANK() at the beginning of a line
> (suggested by Nathan Chancellor).

For the future, please include this changelog underneath the '---' below
your signoff so that it is not included when we apply the patch.
Nicolas, would you mind snipping that during application?

> Fixes: 7dd47b95b0f5 ("kbuild: consolidate redundant sed script ASM offset generation")
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

-- 
Cheers,
Nathan

