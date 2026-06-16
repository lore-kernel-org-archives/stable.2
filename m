Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24F1A6803
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573591; cv=none; b=oBJriZDncHPEaOQIR+ZpqfJYLIpv7lw13VEsEpNmJ1gkXp8UHVGMx6XHP/uqSNoykku3E8mJFA0FlW9+8UcwuiU8iWkpNafaW4s5jBPbApIl4RMfuL1D2oY3R9J0bB09vcNF+oLUKc4ZZNzmiops7w03KODfwTWP3PvOd2ubKz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573591; c=relaxed/simple;
	bh=rUoJvtXXMtSKWkhksKieFnwPsYS9tUOLqGUesGi52zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx+Z3X1pmzwoX96Y61zJINY4jmJeZ20hiAlX7Mtn3n0w/4YVBI8YgX84z05OdL42JtXa8CXrneRwCQ4d8bHuxYCO1PpaV9m9WeAFh5/MPGgrjUFqbl9kLMQoxDL9bp+id+SFkLVK2DFDA3Qf2SuyYwMWdh0/3jhmH4UVpcrZD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elo4vvDv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elo4vvDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F19A1F000E9;
	Tue, 16 Jun 2026 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573589;
	bh=5osW8llRrZgUy1B+gtND+2rpDZVFKu13y6pYaYij6nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=elo4vvDvVuUh2sm86QjC+Te2rgvTjWvec8Ce2xBPGlalCv5tePP1ZWHeGnuyyTsE/
	 kfNYpRYTLu/5rZIO9gHM3jnjWkDJkv/YmkuZ4E/VTkQ3uoXJKAlZlj1HNjTJkj4yZb
	 nN4LnPMPixODzk16F/uKK42LQqnzROUn3tG6kiAf3cY2cf8qv940hYV3h8pyOpL7kf
	 wGjQepRajjHRkl9ZsLqhZea3NCKSxwE5i+H9rzdIQqR0DWVqrAFZo3uW/589OApJNV
	 Gq1bnDfwZh8OErJ/Jw/fPS50n1VsCsleaDek+uUQQkKhkiXefHZuUlMcwl5XqkYVpc
	 PD5zVDTmSYBkA==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH linux-6.1.y 1/2] tools/lib/bpf: fix const-qualifier discard in resolve_full_path
Date: Mon, 15 Jun 2026 20:33:05 -0500
Message-ID: <20260616013306.3850069-2-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616013306.3850069-1-clrkwllms@kernel.org>
References: <20260616013306.3850069-1-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Clark Williams <clark.williams@gmail.com>

strchr() now propagates const when passed a const char * argument in
newer GCC/glibc combinations, causing -Werror=discarded-qualifiers to
fire on the assignment to next_path. Declare next_path as const char *
since it is only used for pointer arithmetic, never written through.

Assisted-By: Claude Sonnet 4.6 <noreply@anthropic.com>
Signed-off-by: Clark Williams <clrkwllms@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7bd6aff6e260..33b214a91338 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10748,7 +10748,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.54.0

