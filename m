Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793884967;
	b=DDrYJqHqFdccSVRukvp5L4wv87Fuvw5+CltF8xF1lAeM3rIEKKzSzACwGw8d2TBus3Y2
	 F7N3ar3oVPO0C4Dfsne31fGoh85pCCLjFsxZqGXfrHuGag0v6ad0VhqbkkzcKGb+lEMrF
	 /lH0jSmTyy4pDR23iqx1DxPL2aZSiLVb8koc+ATLiUHOU4vcH7K9950iWDtPITDFmrobb
	 KyWJykBfoiOlF6Ook0gn/igAXZ+HljiOUB35MMmQoRGueKJGZiwIfl2JEhGzgnn78Xpjh
	 c9w/oYiZ6Azrbw7xGCCvRxGPHVFGVZLtf6hmk7xUo3imYNNMi0b7gLpGBBm0pIxT22Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793884967;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PmLgfONm0B9kDi1GLc/kUSc/oZ1yeBtj5KqaQkDNgWE=;
	b=l/a7hygobFKoVcRJdIgiS3n3pEKDDd6C1IhBIhcIKLpiOdy+p7RoIzm88zw6kCeto7Co
	 kCZLsm++wjz3GxY0sP9QAzBslr6LVOFprnNL6ZfSiCOak6WH/4shyy67+Ml4iGTH131YO
	 nOmVMi5SgMGDpj7fRc7dpl5Mm38rX2rSnxoDHUSEx+gAzv8OWv4uinW1CQrn7cw1c4aUh
	 mzheKGs0ERg4C57Os/gyqhaHl3+Af/m7zh/UzrHgfDXYsF95gQsaXFYjYpDneyTgHBGLB
	 WFbumB3cLOaYNGmQm15DHhxvA2S+NXIwFg8DFHVTP2CVhOch78ieDmde+hg7xChNXQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAr2QT90;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37910606D809;
	Thu,  5 Nov 2026 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LAr2QT90
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3E91F000C1;
	Thu,  5 Nov 2026 13:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793884966;
	bh=PmLgfONm0B9kDi1GLc/kUSc/oZ1yeBtj5KqaQkDNgWE=;
	h=From:Subject:Date:To:Cc;
	b=LAr2QT901Y+36f6XoQd0SRA85p3FJ5jGKt2xU4Ssz3ZjhjVbPECQwBJy8IHcQYN3s
	 YGSqQNxmcgmcCzYi1UPxVmWcqqTKo5BmOwJ7iJifK57Z42cElH0mHHJ/ZUl+usKsck
	 SuNMxgPsBGmrDorl0FNK8opSAjhQPTQMKwcRTfGNBj05rUrDRjNf1tq+lk/RYhEBFh
	 wBWHhfVL9kGWmJ8gi2w/YzbsGa38ZOUwP4fDTpge/m5G+9XUg02Y4WCkw5V6PRS7Hd
	 dRtFxPXBY28tM0nTLicnqyF5+v7xFcehUNytj5HBuCEi5FYczmbIv2+8KJRe21Qczk
	 nNkJXWO9KYhMw==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/3] arm64/gcs: Store the GCSCRE0_EL1 register value not
 userspace mode
Date: Thu, 05 Nov 2026 13:00:11 +0000
Message-Id: <20261105-arm64-gcs-store-gcscre0-v2-0-954d5bffd69f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN197GoC/3WOyw6CMBBFf4XM2iG0EAiu/A/DotQBqkJ1Co2G8
 O+Wx9bdvcm5jxkcsSEH52gGJm+csUMw8hSB7tTQEppb8CATmSelEKi4zzNstUM3WqZVaaYEJaU
 ks5zyplAQ0i+mxny25mu1ezfVd9LjWncQTO8pTI47BrVyhNr2vRnPkS/iDFkLWNOdWde+200vN
 vh4VPx95AUmmOqyUaUUaa305UE80DO23EK1LMsPUVRK+P0AAAA=
X-Change-ID: 20260911-arm64-gcs-store-gcscre0-2e3e246e6f7a
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1938; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Fp7oPz3FzNcGX9WflaVw2B2izesgMMHdYL9LcvF2wwU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeNCv/bTxpOfdDDcOVe0Xlz5fcm2NWoMy0sylv05QvZ
 /Q8Sm+VdJSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiVe8Y/tmkSLywWrjq3fv/
 +ho5qV8UmLkedipZrXe016g+6LrNv4aR4YullsdzjuzknQIfonU/uMn5S3Aw3Yw8JHzm5do1M4u
 XMwMA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

At present we store the userspace GCS mode for a task using the prctl()
value set by userspace rather than the mode configuration written to
GCSCRE0_EL1 which means the register value needs to be generated on each
task switch when the new task uses GCS.  Since the mapping between the
two is easily reversable switch things around and store the value that
we need in the context switch path.

While reviewing this Catalin noticed a bug with handling of mode during
signal restore so fix that, then do a small refactoring to move code out
of the header, and finally make the switch.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Add a fix for failing to update the GCS mode.
- Always write GCSCRE0_EL1 when setting it for the current task.
- Use u64 rather than unsigned int to store the register value.
- WRITE_ONCE() when updating the stored register value.
- Link to v1: https://patch.msgid.link/20260917-arm64-gcs-store-gcscre0-v1-0-3c9fa9213bac@kernel.org

---
Mark Brown (3):
      arm64/gcs: Ignore attempts to change GCS mode during signal return
      arm64/gcs: Move gcs_check_locked() out of the header
      arm64/gcs: Store GCSCRE0_EL1 values instead of userspace mode

 Documentation/arch/arm64/gcs.rst   | 13 +++------
 arch/arm64/include/asm/gcs.h       | 25 +++++-------------
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/kernel/process.c        | 11 ++++----
 arch/arm64/kernel/ptrace.c         |  4 +--
 arch/arm64/kernel/signal.c         | 28 +++-----------------
 arch/arm64/mm/gcs.c                | 54 +++++++++++++++++++++++++++++---------
 7 files changed, 63 insertions(+), 74 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm master
change-id: 20260911-arm64-gcs-store-gcscre0-2e3e246e6f7a

Best regards,
--  
Mark Brown <broonie@kernel.org>

