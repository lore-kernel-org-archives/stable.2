Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02143876BB;
	Wed, 12 Aug 2026 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552011; cv=none; b=FifS6qOSzOBWghrAem5uTCix6oF3US1JCZ8HB6dsIjgJbyhUpYedAIuLpwu7VpaLkBrdmWOGUZExRTkbZBRnvuIuYiNX5+WFNAjMdJCgFHlBOOjywlBQWiGfF2YjW4iHgMz/ck5bNvmTa5TTg2tbWzUEJBh4N64H4SNlNWr/nC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552011; c=relaxed/simple;
	bh=Xn1LuF8TySnWMvXqzBdBfiwzIB8VARJpc29I9xzHMms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhC5Z7ajRdBp0Maav+IsEdSYpXty5Hl5atA6qn/6jWj8oGbd0858owk+s14B6B+a/3miRRAe8Q3VPs6sqkaksd283dvW9UGKJattF8GsLmkq6HdxJhCREdf5Pdg2Uvc6EjeiacAHG77X/z3PfGgjM2x4giPawiaWJCPueRAy7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFfbfPJ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFfbfPJ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FCC1F000E9;
	Wed, 12 Aug 2026 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552010;
	bh=8YzjQEdmFeIZz2dVD2KntK1d6Hq9jpMIS5ckAdDZquQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eFfbfPJ+9NtuDmDxFJVT45PX/28M/dHsbCYCfrrM/LOtrQmwMlgTyyEAEr6RLTKmT
	 d3jOa6FZpCLjVK0N0ZkkWn5ZjxizJwMjCr9yCpJmFyL8UgZO4yMT48DY41ge12r3t5
	 DAOaUJ5wQv6vBKtqdIw8awxGSI8WArrZRxB4BuBTdaZlKxZKEoD9cNNHAUGJO+SBt3
	 l6LzF6PdkNhYD3gtxaDWTtxPH4mG13IAV1hx2TZ3JkoF1t7udywBfsEbEmdRcRhiAV
	 EOV5Sb++KOlMVvq6sZuDyuMsRn78x16iJczLUfU247EGkxrniHvp3oBawb+I2p98xV
	 cA5q7PZb7b2gQ==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root *after* making MMU pages available") / CVE-2026-64561
Date: Wed, 12 Aug 2026 12:26:38 -0400
Message-ID: <20260812161500.10001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 11, 2026 at 01:41:37PM +0000, David Moreau-Simard wrote:
> Is a 6.1.y backport planned, or was it skipped deliberately?

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
