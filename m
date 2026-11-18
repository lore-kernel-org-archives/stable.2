Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013685;
	b=e73tuGtfNDmaPfOUDaVI13lU6TGllPWhvKNWdoRDzptyfYdnB0PyNSo3D7KyT1AFdIJF
	 RN+o+rBxwyzmSdrNgyZZO/8jxGeGQ5F06V4iOpReld9FSn9Nx1t+P/gKy2kS14JaSJXfd
	 Anw8rPoF6ThuE1soaUOUfxhVhsoRuBO++lgvFLSDItSP2t3mIdYAKz/thr72aT6A6Hdbr
	 YEOMEHodXl888vmLLFYsWBXAbth2H+6VEalFO2YxTRbVfX83KtOif58I1ajybhC364vv1
	 1zfLIIdz+cGFbL7dsmGqxsM7IiYZ3w/FmRu1FP0AlRzU+V8KYDZYPxLszvLzdcjzQQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013685;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xk2u0IFYzMOmP4mw0YTVUf3YzRzuPFILTqJcr/ZnYVI=;
	b=XU6516KCIn2gpR3L/yr6DprYeh3At1/5jmxWs35xas3+WMQvSU0Tgm3RZNWvsifHgvER
	 gUpkElA6AOaJGVRbpFGAD7uz+aTaJZJ1OJKB4Kt9Szvlwte/i1wntRORLKDK7WdEAnRqv
	 /DQFAJyoarjUKRjZNBOKzY7fOORKQ2i9RV9ZN7idxJ+eLeN9Tz4yPVj+bJxFr8IZmeFxa
	 rY+UwI0G1JHpS2HjKiEBch/eM29EWIvQDkQb3KUQj820UyJfvkpE3yo8ub7qziWp/0Oq3
	 ZvmMQWvDmMmenelMeMaI4IW+QPiYAGD9BSykmvXSoA4SiuVW8Aok0lCaUSKPRvgkdxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrJRAilG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902C60A2602;
	Wed, 18 Nov 2026 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KrJRAilG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245EB1F000C8;
	Wed, 18 Nov 2026 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013685;
	bh=xk2u0IFYzMOmP4mw0YTVUf3YzRzuPFILTqJcr/ZnYVI=;
	h=From:Date:Subject:To:Cc;
	b=KrJRAilGb24q6cnY1AvdfVe3lSit+hPvoj43uhV5HP2jcKzQH9nwDG4+mxoH+ARNj
	 fGLhdUDM1Y8YlxYB4jg34ulseICbvjC/KVCdnELc+Ob/LNng5JsJeBmDEj2KnCmvZ3
	 m/wAbaXhJqfXZ2djCmUyHTyqw7GDI90odcMoV1oBACVfYofPa63uMfYR1TLTwjwHYO
	 oaEBcYMo7jvDKjpzBZ0waFfzf/xWwkxWem9faXUQW2y3EcxkDrDEz8sFpe5EHHfJ9C
	 2lU69y1ONxHpmCTKFnRv+F7rwdg3HQQsh1d+b/33RHxHK8QmWjbs8aazjJTnrdBrp4
	 w0z5nNRPBd/kw==
From: Gary Guo <gary@kernel.org>
Date: Wed, 18 Nov 2026 14:54:26 +0000
Subject: [PATCH] rust: io: call `iounmap` if MmioRaw region constructor
 fails
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
Message-Id: <20261118-dev-iomem-v1-1-2c3193c85c43@garyguo.net>
X-B4-Tracking: v=1; b=H4sIACG8/WoC/yWMQQrCMBAAv1L27KKpWINfkR6y6WpXTCrZtARK/
 26jxxmGWUE5CSvcmhUSL6IyxR3MoQE/uvhklGFnaE9tZ4yxOPCCMgUOyHSm7mrp4izB3n8SP6T
 8Xvf+zzrTi32ug1qQU0ZKLvqxqrfEuWDkko/BaeYE2/YFW5bgsZEAAAA=
X-Change-ID: 20261118-dev-iomem-eb3b678b5a8b
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 Gary Guo <gary@garyguo.net>, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795013681; l=1569;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=bJicDS8Enk7JiUI6epOZtEqK+3PIAnBShgsKojLhHsU=;
 b=Jvs37/gryJmgY8eT1fMZp/jUrM8DcPn1i2NcclgqGen/vvTK0tTYLreLwfP4dzXI+4VAq98oU
 xyj2X1iu36eDztuFWDfmVIM+mPhQ8IbJmrxbHO7OHH5xUbONoXPhqc2
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=

From: Gary Guo <gary@garyguo.net>

`MmioRaw::new_region` may fail if the IO memory region is insufficiently
aligned or not as large as the minimum size requested by the caller. In
such cases, as `IoMem` is yet to be constructed, there is no destructor run
and the IO mapping is leaked. Call `iounmap` manually in such case instead.

Fixes: 1d0d4b28513b ("rust: io: mem: add a generic iomem abstraction")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-26b373ff-c31b-4f16-9765-2ff8fbfd4184
Cc: stable@vger.kernel.org
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io/mem.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 32a919099dcd..5bf5766ad36a 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -294,7 +294,14 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resource) -> Result<Self> {
             return Err(ENOMEM);
         }
 
-        let io = MmioRaw::new_region(addr as usize, size)?;
+        let io = match MmioRaw::new_region(addr.addr(), size) {
+            Ok(io) => io,
+            Err(err) => {
+                // SAFETY: `addr` is the returned address of `ioremap`/`ioremap_np` and is not null.
+                unsafe { bindings::iounmap(addr) };
+                Err(err)?
+            }
+        };
         Ok(IoMem { dev, io })
     }
 

---
base-commit: 7cfbf79c66c63e807ea452abf0546e6f6d6833a6
change-id: 20261118-dev-iomem-eb3b678b5a8b

Best regards,
--  
Gary Guo <gary@garyguo.net>

