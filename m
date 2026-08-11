Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5E3403E7;
	Tue, 11 Aug 2026 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484882; cv=none; b=oifLTzO/2OrgE/AES0EHYXB8EltjyF/1g2jDz7mu7popGlnPffRuukEiR6QPcQI+tPtUHJc9veruU7mV3d1lodQWq9DUAuBRoWqz4vzHSByMklcMMXC9+resrMijVqcAPmT2iby4ZNJRPu9mgOhwET14XsOYrJm0ABdYXZDqUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484882; c=relaxed/simple;
	bh=+brMffFdS8jyZ7e/Fdf4eJQ6Q4S6Sr4h4k6lkbSX3qA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=imc+68Vlillqx8Tqjh1cVUqA2gBNdIf5K1la32wb0jsN/9YDjOstfb5viR2ttVV4vJwxbKiL12WBxIeLQjt2jPD9nH53omHADAKV590qYAWPWgir8/HSSaMxp5h6tB4S8O5JCaVOlHrYz7CkGb1SWkF0uLYJ0Lh0fmbehi4EZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAYrd1ZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAYrd1ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391861F000E9;
	Tue, 11 Aug 2026 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786484881;
	bh=ldJUy+mzYfFP+vTdoeV8DvQmSIj2flUuiuA6smQkXlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EAYrd1ZSyenBjwi+GTlIj0fT3POLmvwRPTT8Z5Agd8LitTYnULbzv4neyKZEIXf/G
	 CECisP6uHKGFpl+T7DN5igAIXnZDhB8T/3gMciPbskwqGmvHfHFPpY4UNMcxICMXHr
	 +p0iq7ntd6C0U0ic4qwSeHXk8C5H5QAestbIIX0jssm5vruTd4pvy9z9VKpm820deV
	 SJVnxV0Au+qqELN9lKgxf4P4XNyF+3Z5U24W9ZGUZ/Pa6lRiqLfq+VxxG0FQn3Hq6z
	 cEaubLv3FE6jYXgZBOzSCj2FDA48Cg8E3hg0yszAm43/ClAPyf9+/YHDVLxAld0VBa
	 ZRfVPSVmOx4hg==
From: Richard Weinberger <rw@kernel.org>
To: richard@nod.at, Ibrahim Hashimov <security@auditcode.ai>
Cc: chengzhihao1@huawei.com, s.hauer@pengutronix.de, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260724074327.73582-1-security@auditcode.ai>
References: <20260724074327.73582-1-security@auditcode.ai>
Subject: Re: [PATCH] ubifs: fix out-of-bounds read in signature length
 check
Message-Id: <178648487886.3958324.18328006518346578815.b4-ty@b4>
Date: Tue, 11 Aug 2026 23:47:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Fri, 24 Jul 2026 09:43:27 +0200, Ibrahim Hashimov wrote:
> ubifs_sb_verify_signature() bounds the on-disk ubifs_sig_node->len field
> before handing the signature payload to verify_pkcs7_signature(), but the
> check has the wrong sign:
> 
> 	if (le32_to_cpu(signode->len) > snod->len + sizeof(struct ubifs_sig_node))
> 
> The signature bytes start sizeof(struct ubifs_sig_node) (UBIFS_SIG_NODE_SZ,
> 64 bytes) into the node, so the payload is at most
> 
> [...]

Applied, thanks!

[1/1] ubifs: fix out-of-bounds read in signature length check
      commit: d68851fbac230fabaeeae25b19fe60ece173da88

