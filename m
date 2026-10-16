Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6131DDBB
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117217; cv=none; b=ZK1IbfH0F2+1mpLiROVBKTHlG7cJz0hqy2bsXVNIEuyoeY7mMdgLrW3uNr/aiZgCO02gaq2oHI/D+e8HfyKXlmROFBIL89KmM5WomHuGd63Y0In1S657uaVFKe2hPxuQVmqI4YIrYANubw67FwOEF5SppNFRkGBj+yJq6eBTYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117217; c=relaxed/simple;
	bh=uMNUe9ZHkRV/QimzWs1Y3lfx283d+iaVib+qDCbrxJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awPKZuWFg4BRMt9GXfKz+BENMiVC7zBchTJFG8KoO08KAhHf/tpWlQPbDGL6EjfFg13//zUaCzjiugC2nX3ElwNkmFPB5zNOzWhZ6p94MOtbAAx01OmPld8Ug9mArX2VgPY8iRirqO48/vT3WJqrxZm07Q8mu22nLJLugqtirYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=P7kyhPA/; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="P7kyhPA/"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-141395927feso11463078c88.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117216; x=1792722016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMNUe9ZHkRV/QimzWs1Y3lfx283d+iaVib+qDCbrxJs=;
        b=P7kyhPA/SUbcMqTpYArePGIOW6HzrdqGoTTNVr2hHY8hgq+5uOyx2zaDXZLQKYvUtc
         hkRD0NVK8FiCu6G89YkM5DDSCz1DVSIEDXWv6izB3RNA+thMrNhDNKM1kiniwDwK5Gig
         1tboQPOFqMAz/A8CKbxLK6OlB1aPh/jKhugoe5In0E1HXTfkXIUj9VjLH9dDW2hvBT4r
         U2ebC0uVCVu287AzDV54tWaKGzjUeufAaKQAva0zkrI44iiNYNgjGq7IPszdR1s1b7sq
         fgy1h9SKtUHhmoS0+D3UET9BPyHs8i/wsTglOpJdz0hnKxGA8KJjwZImDk9AFXGmmJsJ
         ZeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117216; x=1792722016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMNUe9ZHkRV/QimzWs1Y3lfx283d+iaVib+qDCbrxJs=;
        b=AGDEhCvnFrQ7OZdcOuvsAyYS3Nu0/fmkVVc5eRI9HB95Nvm29/77CCOPFAUDqJSBR2
         jEk1yM+tsO94Yebqun6QJS/WYno0fVxREOCk90+moDr6MImNb6JhX8M9qJg/imcWA264
         swbtUN5NTUCp9GBSD8H1ao3KAW+XTYvny+c8qf0Reu21E/d4h//tXe3lFrZHkO+62wGK
         rvbLJ7bbpW69cfTMrUpBezJGJwhJRLOtue6+d2bbpaMRLhyPjuE8hTVMwghTvDvUE6B7
         +fgsMkUKZ9ypX053lU6tTp1zYzEvsDZ+aNRMRA/8sppfXxQAYbW8NY5RAEXdcsD69R3L
         yNyA==
X-Gm-Message-State: AFq9FYLuo1zD2TCDwwkYIPPNgDVDlBIWzILYh549/ru3UcA1Uxzctl1T
	O3MbBIlGpjIEtmthB7KhCl93inbv2HLO7z1M/O8ZBAbG5dmB0aKz4buJ2I+m5bW8LDOqoj1Qzud
	r85igZb9pyQ==
X-Gm-Gg: AYBFou1tIsKOPcAxIhmC1dvr9Pbd5rEPQ7GFkSn0g6SfXrEviHug+ruMdIfBoLwt5YW
	41U3lcdeEas3ggpSvF1/Z8Hpj5Pp4igLMoJsXbxl1eKSTxI4XuE7smwgdKWaNtCHkhzzcI0f3O6
	lVZcmJjhUkvTasZ0aASg2a228g6OaTS8jXJ4fiem3TAV27KWPjP42zlXWG3kVtu1Qxc1erE0WJ8
	AwQmTlyRHwYugwHx7oKBJPuNU1p3zdCJ18d9OaXL6tBQb/TnZQuxY95fl/Ij8oswDjMtpijE6e0
	y4meURAq7t2oM4a2m5fwxJh6zq0kLZ5kvlqdH+wAkoNryQOvIJLe8lSdYXxpvXBtqJHM8ZMp7p1
	sdrGrhUkAdWJ7GZ6L2kvd/lzUWVgH8TAaSM+O9u80I0Q07T7goZN+5FdwyOIBamH6IjZZnI+rGo
	5SXxQD6t7xeApz0NXFnQsNLRwq5zcrNZNMXrrUcRER5289a43UKaM008E0aekDRTJLFWEEt4urI
	P5Gx4p0+Hf6g+fo7CvXkMLodwJ6bHEzNTnKbbUNA0dwZlR6a4aIVJR7nmuB0Jc5HZI/tQ==
X-Received: by 2002:a05:701b:42c2:10b0:146:85b9:970b with SMTP id a92af1059eb24-16a610c9bc8mr34000984c88.39.1792117215179;
        Thu, 15 Oct 2026 19:20:15 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm1434734c88.22.2026.10.15.19.20.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:20:14 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y 0/2] CVE-2025-38060: backport fix series
Date: Thu, 15 Oct 2026 22:20:09 -0400
Message-ID: <20261016022011.16938-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2025-38060 to 6.6.y.

Apply the patches in this order:
1. bpf: copy_verifier_state() should copy 'loop_entry' field (fix)
2. bpf: abort verification if env->cur_state->loop_entry != NULL (correction)

Patch 1 preserves loop_entry when copying verifier state, keeping cloned
loop states consistent with their originals.

Patch 2 aborts verification with -EFAULT when loop_entry is unexpectedly
set instead of clearing the pointer and continuing with corrupted state.
The code changes in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
