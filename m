Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129144605B;
	Sat,  3 Oct 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055778; cv=none; b=QxgQyGsjxVUZXV3dovzlknu3eGVgJukZrB7PKhyKsmp/vFg8i1cWWTF8KGamfZ+3+CzBOgENMbfBDClgvNS3f3K9Ap3fWJRx1Kp6+V3GhonR2g4RY1VgyDldfrgqK447WuMV8eXqeJKm1a306cf/Oxu2r38jBb379ZyhKeYsx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055778; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBQcgRa4SGese5KcQRpKYPgugBkjSWFr6k+zvdaX2NUoK/17sCzYNs9XS+yVtBhFb6zkgrPdt52dfGXRYDPOFlJPOnynYE/7qOeBxkbPaFZm7/vcF7il9HOmN2YUKffWMiEWmxJoaczl8XE7i2Uy9ltYYHlN87GAR1/k582IZEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMaE8i7n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMaE8i7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AAD1F0089B;
	Sat,  3 Oct 2026 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791055776;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XMaE8i7nZ7VOg0GkVx56zg2JM9QtGOMPrnVt7eSDrksQKsPyk9zD/PwmQ6SuYnlg/
	 SQkx7jWXR7ygoJ6k2MZwKZYorON4SSPrT/yPFlMts9Es3ZPH/hGqWLGzJBzIFbRYER
	 O0RyFC75HvgItnixU9QKRzfqrfowrNOl5xZ4vf98lZdHyeWT5GmfF1UOLaG4r8wMZk
	 n+cU1DVKX9lyrbEh/+f5IOx3IeHzOBzsI+kic9Vp4VDat4/QB+scNHOa+ZPh35i6Mr
	 BZ5rEhavsS1sbvECbNCAANXv5D24yeHtDpqfcS4RaQtCxu42fauiGPV7lvUpEqPgTD
	 QF1l1tjKieX5w==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
 Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tipc: fix use-after-free in netns teardown
Date: Sat, 03 Oct 2026 19:29:35 +0000
Message-ID: <179105577539.1402591.8203580811946121686@kernel.org>
In-Reply-To: <20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261003192530.2414682-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
