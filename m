Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3273955DB;
	Fri,  2 Oct 2026 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975063; cv=none; b=M4I50gSkvWjDZ/ifTLjfRKDKn/BZIgpVxtI7sW+piHI+xdstpOEGLI+sQrb4//XJX++2F1uiLHYYur2YU+khhNs7L03/+tIpQ5iemS3XC5/UgpUfkAlFG8ylJKmDceScwBNp0MAeNbMNdhJDS9F5oFqNUDiHczV3LRJbkzSjRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975063; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gmaiVrUfHL41cCUL4CuFpVy2gsCfiOdFbL7rO+zKnHZ+aDoNrOsoTcUAWoTpRswV4bSe+D79jdXd2ZOVa1rzfIPfOTNe1eRHg7OprL+EoGAHL9dbBC4UkE8z8Jt0ZWAR5yQSh+fUxx2iNwe8UVQ8QZW3JYBlpuE8SfaKEE+z/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hziYWh/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hziYWh/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C06E1F000FF;
	Fri,  2 Oct 2026 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790975061;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hziYWh/Hp09Z/tRbujSkjMlox5VKujEDtqJe6HYxT6Eti2+3Myyw1/HgTPftpgg8e
	 1b8maHOmHZkByMMtLCdFly0ecFgRfHuA/0eTIIq3F71NOtuS8hnwaCw4oIP7d15Yll
	 dhUxYG+QVZPIRAT+SMeorbr6fompUGvaq4/0RSKlEEFfhMNTLEBsQQKYzqBkE0UkUR
	 3p1XtZ+7UZ331vTHKqGPIDCEeUKaoQ82sWojsRViJdrNJTI5bOQuqymz9tvmigkiUP
	 W1wt05CqwYnENbNGY3ersZM1244VMsYCUILb9yMpgARaC78DVW/7mSeO5zP3QqG4CN
	 400uaJfJTMNDA==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Jon Maloy <jmaloy@redhat.com>,
 Tung Quang Nguyen <tung.quang.nguyen@est.tech>, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] tipc: protect received keys from concurrent flush
Date: Fri, 02 Oct 2026 21:04:20 +0000
Message-ID: <179097506092.1402591.13812981146173639513@kernel.org>
In-Reply-To: <20261002205932.1874012-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261002205932.1874012-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
