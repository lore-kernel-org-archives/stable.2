Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A9442FD7;
	Mon, 10 Aug 2026 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406283; cv=none; b=Cpz9xuzj95maGaBtWY9uajhQM86lq6O3yk6cidWK/bvSamyBtPKVfdwX7O9VpUoH0kSBQQA4XBlaMsOg5sk/1Jqg4umFMehF4kk1pR+VSAhgluC6Ug/frziA/kD5BYAlduZQeqyFK9akDCYzlTLn1+9O/nuwjkvt/PjA8ZSfcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406283; c=relaxed/simple;
	bh=VDtHbmeKqh6oRnyVwsPt6yN29w5NWtQXcuRhzcrZVbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n25r75zW3lnDN/5wTPEs3+KjqhA+Va+cIm8lMh6hu5NjDirt+T1StwojUl5satW894CRbekLERd58TfAKl9Sa7Z3TYw0CsptLjJgdH4bnudaLVt/S5ve8/pe8TDpuceRofO1nBHijttYQLNT41SxCNSLbve9z9byeHQuO0zUNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbI9PdyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbI9PdyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292ED1F000E9;
	Mon, 10 Aug 2026 23:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406281;
	bh=Qb5Px/WCo590F+EXyft+FRFZ7I6ikGxdKrhx1/Zd1XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbI9PdyK4QzFQZaK50mRdWEwBOARjR0B7m8pLd5+AeUZiar7WIBhbrizOc/xM0JMZ
	 K8gQ7bmXNxM3DYLl9pK5Qjvl/OBw1KW0RiT3/K7BRPFqjeAG7zqEknwuKqilEAFU4P
	 Xy/k9+QR6osdJnujLfkiTo/ZFub+rVfwxtmzc02cB2r8s6mj7IpoeNucZoUEu8C4Q+
	 ein6ZgJtnI2tnRpr9LT2EUR/z6XkUUITK7mAPwEgV55sRpSc3g7ihSZDDfAjCl4uik
	 R9hlPvU3i1Ul3J1r27/QzXFS5y034w2DJuypBkjroHLu1LSwu1lcZq8u5NNFWadtVT
	 U5DawK0m2ucUQ==
From: Sasha Levin <sashal@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re=20=28SUSE=29?= <ricardo@marliere.net>
Subject: Re: [PATCH 7.1.y v3] selftests/bpf: Add tests for sleepable tracepoint programs
Date: Mon, 10 Aug 2026 19:57:44 -0400
Message-ID: <20260810234738.0006-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808-selftests-bpf-sleepable-v3-1-45ace406061a@marliere.net>
References: <20260808-selftests-bpf-sleepable-v3-1-45ace406061a@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ rbm: Removed hunks from (new) files:
>         tools/testing/selftests/bpf/prog_tests/sleepable_tracepoints.c
>         tools/testing/selftests/bpf/progs/test_sleepable_tracepoints.c
>         tools/testing/selftests/bpf/progs/test_sleepable_tracepoints_fail.c

Queued for 7.1, thanks.

-- 
Thanks,
Sasha
