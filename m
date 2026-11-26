Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686829;
	b=nLFDLc6lBd28bRq7FxLVH9P8vtO00c8uenrm8ixtKFNsTAUxr7TyGp7Z17aLFGsz750A
	 XU7VhPvYpDOgexxsalMXZqEHG8yEGgPwUARcLVNAR8Q5jY5wv7qQ8Of1gMu/mXkJ0hsOi
	 YQf+jCiOWWXtIRAqTpdcYQRiv/68BTrpA0BtlndiEuTMiO37YLHUV9WtTeGQ3RsWiOw51
	 8dEhfRLIcLj0hNiujISeMzARnY4aTXR8p3wqfNrP7khUpbutOMlQztikhkThrZ3mqY8M6
	 dsvhBOyerQnlZRZzT5tfzLbCvyVG+0PBz5y/jYZVp5snVHFViEZwhMGeUF9HNI8KVTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IQ+jDuVBv1HbX1b3BBSVrbjflr2E8zhivXziNzPhcDM=;
	b=TMoMwbDXMsMqVbRD/sDaWRHCkNI04HQMIq++AEcmgSozeahcINGsVEfKdU8AdeJkVBoS
	 wgkNT3jKJRXLipT/smlbcEnVixi3qOP9wGwrcIeU7NFFjnhWfPKuHPmisxenRgmesicTT
	 7AWZ2CRshhT+JA4jAFYCqSC5+tXIJyhi0nVyLQ3jYS29CFrTlg+16cCoi+vgIfD/faz//
	 fqv/7nA89iibnurFfuwaWbJ2WZC2pa8iSsSDVqi10X31AZaO4XgXbndqZn15AEt2b38BR
	 V16BnzWAZhdUPi2RqfWx1ydU6UgTdrUGH+JoaaW3FjmxGdAqjossBGsswpXA7+hJcig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ATY9mf21;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D89606A33B
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 09:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D89606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ATY9mf21
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4bcda4c853aso255926f8f.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795686828; x=1796291628; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQ+jDuVBv1HbX1b3BBSVrbjflr2E8zhivXziNzPhcDM=;
        b=ATY9mf21DZwNhmZpYSdtB3X8MG95289N7UHEfn2MzH1YO6Mw0I4FY6KBInec/MSWAN
         toGl5bwYMk/xVPG2Fux1x8h3CmZipQrOoR5NC+nzOzKoGZLuD7o3dks5fzithnN+E0XO
         cnzY9EjfZK6mIhrOPKyjMSv0bUe+5MGngOtq5Yz8qamTYn4zPVoZRAb0oKt5bV2Ns8AW
         hXT3WXnkMk+37oKwYnS/zZCmNbF/xObSbqfIq3U6aiSkz+gYPq2z/GxzJFsQHm3UCmbU
         yHjJkTjenXIPE0HPFI1mfEY8hSd2uSi84cVfMzqwvMFaPsDuYZMKmtozf0l0/KcvO8Ik
         mTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795686828; x=1796291628;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IQ+jDuVBv1HbX1b3BBSVrbjflr2E8zhivXziNzPhcDM=;
        b=1ETAyDVn//XoLpEaTX6R11Q5c0k8g2n8yLh/ZUFEv1UPiSxhrwH/gieXxBdQQk2FrU
         5hgbaTpKgt7kNnHYU9ru4Ycux+6Y8BXSASsRTFF1kLmVfJaakp1byc8Y9w9EG4MwASEZ
         h1sEcv5ABuCYGrNnAykG0kOkRrQ3zzyOjBUB++55+6QsT0MvhITXDwR8S/lgTq82gtzT
         ojxc27kdlecoNZJPyzeiderEq3dAU4UbogSp5s6vnu6FiAO/GZzceVZ1DF2mSXn+G33x
         S1GKGql4gbmAJPRXVQiiRpdwLGdbXXr/oVRs7ioOKe9xDuM8u0U0p2j9OYr1ymO4J73H
         EqNA==
X-Forwarded-Encrypted: i=1; AL+hErHwaQW9mJw/iUklLZe+GmQrTmpu3WKOb1O6xtQFhdqfV076cfgoU2WEs3WFTunvjGzD8GawCck=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gO/TtMcqeMC92IiKnp22tj/KovhjTkXfGEXybXe80hLBK+U/+
	1ubr6JNXdQF+7z6mYrLOT5tTjWM/7NHE9ZEuCgoqs5uiUpQDzNCWtUuxyPZtAw03yZX6j1hZhna
	q2P6xq+dTM95W6tripA==
X-Received: from wroa3.prod.google.com ([2002:adf:ed03:0:b0:4a2:f12f:819c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59c3:0:b0:4b5:b60:4814 with SMTP id ffacd0b85a97d-4b50b60487bmr22618872f8f.54.1795686827511;
 Thu, 26 Nov 2026 01:53:47 -0800 (PST)
Date: Thu, 26 Nov 2026 09:53:39 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKQBCGsC/x3LSwqAMAwA0auUrA3Y9IN4FXFRNWo2VVoRQXp3i
 8vHMC9kTsIZevVC4luyHLFCNwrmPcSNUZZqoJa81uRwkrhwQkOTXLjKwxk7Zx3bYFrvA9TxTPy H+g1jKR+LB8dHZAAAAA==
X-Change-Id: 20261125-binder-32bit-fixes-8545e4a3066a
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=936; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=EpMduAqe51nfTvXf0d6Ojk5wyRUruSt4ngGPShsiPWM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrCAGpCYmZgGXciGbCpezM5TFDplsUak60b3HpE
 Qz0XGyImN2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawgBqQAKCRAEWL7uWMY5
 RqRFEAC4u5UqJMUvF1FCrevyejCifXyIvacrgWdtTDHksm8L8kB24b3GPQqZ2KiaWODShrglh6U
 sjqL0YoSRNLR4pbS3JcjavmENMfsG8katQCauZI0f+WjlRXQQh+dLFznvojSVxV9ughV/FP0wdS
 k8S6nOrqR+4hicnMWIFoEimMOyAjgrd830ZMZ5EgZE6O/iX6wsRRBmjAPKkTAKISlmnS0UII2SC
 tP0lELozuwgMJ9OJDQgKdLqoWMxUtWn8FJmfMN304p0eiklxDoEIWAuRzZe5qGGQn2eEyYA4eB7
 B3hqgAAL2Q53I7YTlhVTVCzTYV5rKrSq1l0iWBrYDZ38A5zEq6rNV2D4WLJe6QwMZEK4JyqFCjB
 san4mtxyPsvKWYB8Hg7+YkoKmmsHw1ZJKmx/CX7hvfWgJDBYrx0Qntsbx4PygX1NT/b+4WGTqZr
 bEUM2CpIP/tfDBhw5lng9wp5+RFOp3lOtceYXAv3ptUduNZZ8hxLXnbPBvf6JfHnsyV2/yjTkL/
 w8dJvJgyTSTRlqXLF45iyHcRi1EQ63goQNgT1y4lwIdnq2t+Hs2vJu8afAH08abcCkK6mHbFlvU
 FPMowGj64Pk79+iuo0O+w+nv1M9zAcvok9JEMw6WnjXhxDqFYIrg/2UOK7RTDz0fTZ9Zqndc3OP JON+2IYYSZzoVEg==
X-Mailer: b4 0.14.3
Message-ID: <20261126-binder-32bit-fixes-v1-0-22fc21baf6f8@google.com>
Subject: [PATCH 0/5] rust_binder: fix 32-bit truncation and alignment bugs
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This series fixes several bugs that only affect 32-bit platforms.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (5):
      rust_binder: read u64 pointer in BC_FREE_BUFFER
      rust_binder: clamp write_read buffer sizes to usize::MAX
      rust_binder: reject transaction sizes exceeding usize::MAX
      rust_binder: align scatter-gather buffers to u64
      rust_binder: use u64 for node and handle reference counts

 drivers/android/binder/node.rs             | 22 +++++++++++-----------
 drivers/android/binder/process.rs          |  7 ++++---
 drivers/android/binder/rust_binder_main.rs |  5 +++++
 drivers/android/binder/thread.rs           | 26 +++++++++++++++-----------
 4 files changed, 35 insertions(+), 25 deletions(-)
---
base-commit: 917fcbf033154a6c8d83cfa6c88f012b71eb37b2
change-id: 20261125-binder-32bit-fixes-8545e4a3066a

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

