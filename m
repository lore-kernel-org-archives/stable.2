Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219701;
	b=gHL7GnMjM53Dg0PBToFqLLh+l9bDg3ud8yjJNpINcnJESL6OZNVZF1Q9QJ9tq2/zJsfZ
	 JGUzv64wAo2FxeSt0Baac0tj5ge+vvTqCvkX3LIQDUlvtcZplT5XjWbY53msZ+95HV8Ba
	 ywOpqCspG9oW2flYKeDDIS6tDQQz1NMd39wXZTXuVlCCaCLB6PuTdRTVKItVeY7WCg5qz
	 H2/kQqa12m9XQf/hNzMxfDvL0KgkfQ7OXYYJMm+1xSjwI+gxKqv2iicYewZBUqJlXU8sA
	 GmutFbSpfAToEyUS+7J2IBQab09IrRa5YrVnvHBDf7AlTuKvx6xdHrBlJguVi6yisoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219701;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=ZymPgD8p6vGeWNKUW2BLSw1c0urj54v+W0LzDlhnwWwhMa7PVs4GNAx7EjsLVti+w0yU
	 MyzOxoCgergnrgeaIy5q0zoKZD5H4u9zm1a5/0/ud3DIyyXLnkp4RpQQU7d4aMuWN6v1f
	 2cOjiJ6t9wt0UCQuejDjvYUO9xDkQFaHaKzePK7zRckChOts4MOf3nNtdzrz+v8L7o+to
	 v3u7miMYIEcLkDeF1WGS0DWRdc5z87EUxcUjkhLfOMojGK6J3O7EJjp99nYtoRNXCe7yl
	 VALBrL9cvOAp5mZt3/yUkQbpzssjT42p4SIPxfzJec7yXcl3AZFWiri8/yi63ycKr7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2fnTfgn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38918606A334;
	Mon,  9 Nov 2026 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h2fnTfgn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562841F0089F;
	Mon,  9 Nov 2026 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219701;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h2fnTfgnODJfpFx5D5yC90YIt5Owo0/yc3Lf4WILZET6iqBmjQo+3T7G3J2qmxl6E
	 pLp5A8M2L30Whdr5F6TO2M2CyBGha6sRFUKfkArocLWCjvDeVkOb1L+HFrUyDaiuBT
	 XlKBhBT4g7sLicU6H+itgKryFcUfoJ1SiVzQVt2SKdxFl8QT+FwOuM8FDs7TNLiW3i
	 vQ/uFEQCijW3S0l6tSb+s+U1VTYnv8xewaCddUAZHfYu+hVRjzd6IVb8w0lszTAmyG
	 gs18gj31/+1H90aSrmXUyFZCtYFe37Lqzz/b9o8UCaQxmAUC10hHOHrIS0pJwCDUge
	 2376gmqFBZErQ==
From: netdev-bot+sinfo@kernel.org
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v8] net: libwx: fix VF PM suspend/resume flow
Date: Mon, 09 Nov 2026 10:21:39 +0000
Message-ID: <179421969986.488859.13582406441576044740@kernel.org>
In-Reply-To: <20261109101442.84605-1-mengyuanlou@net-swift.com>
References: <20261109101442.84605-1-mengyuanlou@net-swift.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
