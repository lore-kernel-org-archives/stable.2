Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997360;
	b=z4Do3hQVPIqbCX87k4rHMlUDPLkco50Z276sKUrbhqOHcViBy9ECMukbzaqZ1mOeH8Ch
	 cIwY9hgONAAwXpg3HyDXb0mZYduOpjN05Ee3KUXxYiUh22LpMU9bc0tRNNkXAqh/z5L+G
	 d/oLn8K3y0IosCoWaYJCs7LG1kkV9nNLlLvikyQcZwPvAAuYb26yJV6iCB/65yatdQ7bf
	 +ZHca8uZoTzFI5p7hYscUh3WgGh5VDSuuekQbZRHET2rSbdOjVCgz4yuRSgCh/2SCYH2w
	 K0jj+tT1mq3hH/hdyrQxJpzta5bZN40hUn1XptTamRVvKBlOKsDByyBg7eKjx7dwZaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=qs7ZwQHgWlBi4Ms5YQR1v+NPvB9OfucbBIzITH6+r34u9PbkEqese3Yc6zVoTyn7kNXg
	 xizcExRL+BhiKsA5GlrWIyid1h20R4KIt87QN8eOvAMzvISZDfdNTJYr8fZrQFnfgceQW
	 fbDgC5/CrQAw/557oMKgSyk4XLvVLdUflLAjh+BVGgPg3HeNid4VV8EVZLwZJhQY9Qykx
	 uikLbmbi2OG+WWWlHY/KYB3ZzMo9JMR36nRvB0TqU3OsoDhu1nBNJg3xFYRkxRyOTCESX
	 +hgnYDcyY8jFPwtRszBuWtSQYT6SxOPPKuMOlP6dNNAPjAqe0AvBFzHBoEhElR/+TQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6c+j22F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80375606A31C;
	Wed, 18 Nov 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6c+j22F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853CE1F000C4;
	Wed, 18 Nov 2026 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794997360;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a6c+j22F2tQIso0j3WD+9T+/EVHqnh78kteGS5HbaQrhjQCq4w73ph6XHnQf4liks
	 PbGw7G7XguMAqtUlJdNKxEKH8TXNPdDyT+XMioOYTq6DwVrZo5hB+hJ8oeLlCodJV1
	 0KlElXGeScwRAhYtQYJdJ0GeGzm+lfM53VsTH9eMsWH9aQ5mACcrss3OB2jSf+1Tf6
	 J9AXxKD3HwGSPK0ZYM8kgeNL+wsw8TLArW9+vDSVLaZ2ONQNoMcn420pyed4TAPlWQ
	 rte49mKF5mor49A4S/qQm0A1X/eIKu4ekoOpyor4+2nlPHwo3+HFkuzzo317SqWSx6
	 6QX7KDVLj6e0g==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: initialize sk_peer_lock in cloned sockets
Date: Wed, 18 Nov 2026 10:22:39 +0000
Message-ID: <179499735905.3291.10447871915043656308@kernel.org>
In-Reply-To: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
References: <20261118101752.1989502-1-bsdhenrymartin@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
