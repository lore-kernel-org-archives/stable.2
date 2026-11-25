Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581790;
	b=pfqsS2K+XZHoxSpCktwk0MU/zzLgRQiPXdembYFRLb23vxTClBwORDa1auK6nk9EjbLD
	 SlSGrUMqRPKeTScUjlnwkSt/Gl24wFOGSzGVMiWK9EIurgvWvAfIvm18wUclLG4fPIpF7
	 HjBdGPKk9v1CI+5sS9cIZ6knQf+Nu2nwlrWsArv0veyysWD+4GVvCLR+KrUfrhvj0PNOU
	 QQgwJ7sPX+8XlsoVPemmAg9Ye2NwGxBgETTMTHA7PvH9kngtlNG4vA/kL479vWn70t0an
	 4gRrq94toiD7tBhFdQCJwpC6Fcjl6qZCpzr3oBWWRY1Sif+tFgHoCT6i0QxLiYZRsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581790;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=4628hfkcwANG+0zpR97XWve7YJzaNsijTzq9Nf8nIQIye5gukiBdc9VlJrQ+ncc8nMAY
	 /RRnEuFAaxgpbFSFYvuOb55gfzZWwBxrVdERij8sjPDRoTD4UTfuXtYYkXpp2fkzrOmMe
	 nZv9T1E78eMhMSWYVwcPBVr9YUx9vSK8ijRgP8wyAVp6q6a5cD91yXQ+dgrD7xDrz72ka
	 XVAK3c9m9OzySXKyhj3hNahA3+LysHTfrnWSUVeIvYsZ8DryH6P6s0A96CjEaMcjyGoLk
	 7aZ3Sq6gqj7+k/8Fq9kA/dabq7o5LaRxNC3sya2NAdGWGkB0wbYLC7Ajx5kGHZZd4xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGn2NXLW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB35606A31E;
	Wed, 25 Nov 2026 04:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGn2NXLW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555B31F000C6;
	Wed, 25 Nov 2026 04:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795581789;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGn2NXLW28ICyP6zdvioYcV5So9yq7gbivswq4gMFJBt7FqW4L5RH1h65VYtRSD0K
	 P911dBbHhFwHFs2P+rrg8nntx9xvNsK4KB+cKEd7SYZmGUe7GldjSc83OGUEp1ydRx
	 HKGYR416Gxh3tAYFP88oya9uwb+XgxTsW1R8nQRaWng4LDBq5f79hucEpFHn9+vlFk
	 SIcIQmgpzY1vMj71CH6XcD8Ed6qSY+uYAjW62KVL84rH23oV6oXZoANoBdRW3fMj53
	 dovhxx5kqOgxS8HB28/WsSJG75Mm1ozjsM4i+5SxdJEKGZOLIKSs7fiMQx1iqGxktO
	 v4aRfaS9DfFSQ==
From: netdev-bot+sinfo@kernel.org
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kapil Vaswani <kapil@presceralabs.ai>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v2] wifi: mac80211: store the mesh IE blob's
 length without truncating it
Date: Wed, 25 Nov 2026 04:43:08 +0000
Message-ID: <179558178888.3294.13943698848591637747@kernel.org>
In-Reply-To: <20261125043847.885053-1-piyus@iiitd.ac.in>
References: <20261125043847.885053-1-piyus@iiitd.ac.in>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
