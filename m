Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E8AD24
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531555; cv=none; b=olekRsTNQGdkkXXQqdFIrAsc85qYgrF1482KnUORyRxAKrdUnDUiUU6/OwVqSgn3+sssKpqPgJTysqk4WEfh87YpwNeqNhyW/9KjEFcoU8DEshoHsvz40h7IbPUSMooJsgAEm50WOXnpjXHv5KSKzpKf/8wJKOkvoJFpJZNWWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531555; c=relaxed/simple;
	bh=B6epT2lQwuC++n81JPDwkb8AxwZOIA9NyqvwK6q4PdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlHSMOgcEc+VnmFrM3bXLX6bLDbzIBWXXRXh2HeqOs9JwnzPr6rzsv1tFPz6kNJ4GwuWw00ySjM3tv7evQ5RdRZyEiBe3Si5ix1qKRw9FVp6Cc0Jlo7UfP9FggkBAC9NnyqWbCvD8A0KVxhsdzrPox0W2caB8Hbtny9t0LQ87hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwjD/ni0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwjD/ni0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4F1F00899;
	Thu,  4 Jun 2026 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531554;
	bh=AJVNEQcpf+g9Bn42mYSJGxbotg4f5LlVkQBVtMJSEdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QwjD/ni0GjaPfop3VpKjqUwgDeHPz1Gow6/PleVlw/2ZW5/16i81HEaw5+Ds3UJSb
	 pxlLGZra4ntLqVmLmafar8zO5w7Rt0cbmTQlMca6Ba+jdtII+lEjnYP2SeeaDyfdpZ
	 IeIuZO/URX3cUQEM07uy8tW7PP7Xe9imXj2cvAtg/M1/L/nlX/UDnkqPEHx/EW9aeH
	 EumEyhGnmOJH51od4uLve5HoBHiLGQ4kMzuE2O0h6byqxKdoe0RhuiGxzyBaH2xvxM
	 TTim8hPP/9VF7+sV12XG4PMbckxDUBUtyRa5kPPWDwYiO8c2xQZ440J62iboS9z+fR
	 e0Q6bmAGHJtTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to DC
Date: Wed,  3 Jun 2026 20:05:40 -0400
Message-ID: <20260603210831.item005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to DC
> Rebased onto 7.0.11.

Thanks for the series. Unfortunately it doesn't apply to the current
7.0.y tree: patch 3/8 creates dcn42 resource files that don't exist in
this tree, and patch 5/8 depends on dml21_wrapper_fpu.c, which is not
created in 7.0.y either.

-- 
Thanks,
Sasha
