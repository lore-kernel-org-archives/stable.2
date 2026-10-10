Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F203C455C;
	Sat, 10 Oct 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617388; cv=none; b=iBw4wLpd/k9lODNSnLzPv2Uir4CHdwUhvY7CGXsMZJ53QYif68NLAuUdO67irw6XFciqtv7W4+JMljK3jbuBHW9rYG4S/YOFQmW7JtaE45Ua4s03yjHIEqUfuGDkPP5Aja4IrjK+2XGsn/TyTIwB+pdqyqSNqsQmO8IGj3oW3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617388; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wv20Gh9mHnrBK/ps6a7PfKnPuL3j74jv5QNo7pY3GIM/fHPVhNoT4CGoVDc0Ty31jfREwIpSn1iCVt7MYj0jEZq4W2bvAPoXucu4nEboL+/q9Ck5xOueSmHR0hkSubf5N97nY2rrz8C67PCxG3RBXnHcoLy4nbwdiFgtVLxxWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bASEnW3u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bASEnW3u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B1D1F000FF;
	Sat, 10 Oct 2026 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617387;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bASEnW3uJEHFRNN25vXMoVjN7wc9lz/8FaTjMgPLJV/Fx14FWdix/v/60v53W0e+X
	 e6iMTHOmoJXWAbday2ODg122ddJ10yRqGlkpfYbFSlvk3j91AH8mBZo0en29v/4hJ/
	 vM6jxn4up7bG7O5M2d9RGBbU7QCndcXhraGLF7+HtYE/SJROTIW5rxNPeLbQrlcOtE
	 Lqb8eECS1Ay/ZoTbRDziD1vBn9YgYv8okuueZd6ZnptfJX4/M7+uglmzwpseHVhyLP
	 JViwitDrQMHrwcX5v7yjZc9GsWRo0uKV0M89HoDbzjbkSabi4pbkg5ECFQ1nlTeQw3
	 6QLuTGdd6QZzg==
From: netdev-bot+sinfo@kernel.org
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Kees Cook <kees@kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
 Breno Leitao <leitao@debian.org>, Jeff Layton <jlayton@kernel.org>,
 Kexin Sun <kexinsun@smail.nju.edu.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] netlink: fix out-of-bounds bitmap access clearing
 stale mc groups
Date: Sat, 10 Oct 2026 07:29:45 +0000
Message-ID: <179161738576.2527009.11165679388338187386@kernel.org>
In-Reply-To: <20261010072548.2869465-1-bsdhenrymartin@gmail.com>
References: <20261010072548.2869465-1-bsdhenrymartin@gmail.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
