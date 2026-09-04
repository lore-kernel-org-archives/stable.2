Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AB3AA4E8
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490418; cv=none; b=Onh+vg+Q4JbKr3VmbD6GaltqkjFBwTq3anlNPezozACAtA0+dhVUEOsYp7ABK2v0rwsiv7uUiDvhII6c5md/5NP3QsB94WDYEiSIz2rutNzDVe4qeFMldWXtHpz5zRhRwpiRK3BWauyGUtZN7Dht8ODwuryNSN8Ccqm4AIb0NwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490418; c=relaxed/simple;
	bh=amAUJGNaLg+zsEVcWUypkOYd9Vt6wPYm8HQsIew3Q7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsxZYgBxGcPgLM9VMQgTbbn2XfQlRgfWDLbad/S+4+eYIQ2SUEpepBHEakn+A0bOaj/zx7xZqtlLu6ir9WK8XnCTfEAOQAt521D+KqwQOVCS+ejv40/4I4VVVSLrmBrytLzmvgq5PLhePWXmGO57qpBJk5ACcuYPsSbt9caB+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am6ka1JT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am6ka1JT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3AC1F00A3D;
	Fri,  4 Sep 2026 02:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490416;
	bh=EpfG+1g4RpyPca8eXjxOWCrPOKr7jV7ymYJd4KgQScE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Am6ka1JT7Q8djI3emQuco26fkDVJ0I3QG5b4cn+Nd2vlyn5KwVkhD5VnBmUbmSZ30
	 fkuBfmKYaa2zWtzJUKvhPSdjo1wkP3qxRPi3Fs/s7BQBI7wBqonJSBzaxOpu6glCg6
	 z11lDb1UPSWa6FJ0bpW9zLd0lKgzhMqQn7ga4TGtnJB4JWXYztBp1mUJjXxHPS/mVH
	 zZzVzjuG2SBH0saiLvA4c2IQOUwlCtuNceGhY+qxmWwlKZuzCbQ5GDSYQEDxL4Ikxb
	 u37bLHN14KTp0cvwxXJdyyswvIAwwmvLvVEZsowpFTqrl7DlBGQ1GVw0y16xS/ei68
	 EXWL1gM/VHv6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH 6.1.y] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Thu,  3 Sep 2026 22:53:07 -0400
Message-ID: <20260903-daily-reply-0017-re-tdx-32bit-port-io-zext-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903162049.584007-1-kas@kernel.org>
References: <20260903162049.584007-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Use insn_assign_reg() to write the result back into RAX with proper
> partial-register-write semantics: 1- and 2-byte forms leave the upper
> bits untouched, the 4-byte form zero-extends to the full register.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
