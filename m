Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371C019067C;
	Sat, 30 May 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780135105; cv=none; b=ZJwcM00YfrkCsAOi27R/O8M2Bmz6WUD7nybTb/Pc0dg5LmqqRuKWZ1/meeFib8aQ/9QXPpSUcpFu2UbfttVHyCmLgD1LE4rilSAn2tasrUmdFhO1PwEMIEGdCDpc7kEcheQTpJovF//6DQuIEhV30Zq6AyjLzbCcJbP3P/UDsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780135105; c=relaxed/simple;
	bh=sG0QImItOT2BBRg8jhNYccG5X3qLT2RzLfhID0oQdmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODdYjrxLJKP5j1JAlpYYr1nqO038Sg4yxuNOS33avHIzstUVgrnFAe2InkbT99TaYHPWOk7HSnB4MobcqyAnVSIA3KK0isZk36ygWUsErcXus5S0ZNgObbtur+tJxpzeLMKpBxNmQIlMU+TgMHN03lvdlqZUx4xvRjBVYydt0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPlXdPwF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPlXdPwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B531F00893;
	Sat, 30 May 2026 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780135103;
	bh=zqwh8xcAGxwy3ol8cmB/4jVQU8JQ/+FNbi+9K1RM1eo=;
	h=From:To:Cc:Subject:Date;
	b=mPlXdPwFKLsESryzYwzdlMQ68o0eq6SRv7Kcp9ul9G+EIf/z462m1krwfOnGBCVdL
	 DZX4peUvt4SGsE0yl+/dN0zmm1b1UyvrDJ6q1eyfbGgIWtup9szHwtxjCa8kX/6gPC
	 hX6vtGoRiR2sfR1XKRgVdzisO46enHIwgnpM4Uts2rzx+FNrZJpq1nMe4uPlN+FhG5
	 GgssdqeQwCsvXP2pMDwxxPrEcKHqfVPODnq112C09siqZfD7SZcnhk952wQSfr4UuM
	 ELw5zqP4wG941fGklYYQWpTBybpC/SN77V6s/HAuMqMSwxvimvHlikTfHrs7TRXEUk
	 j5H3ucjORtwog==
From: Miguel Ojeda <ojeda@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint for Rust 1.98.0
Date: Sat, 30 May 2026 11:58:09 +0200
Message-ID: <20260530095809.213611-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
introducing a new lint `clippy::map_or_identity` [1][2], which currently
triggers in a single case:

    warning: expression can be simplified using `Result::unwrap_or()`
        --> rust/kernel/cpufreq.rs:1326:60
         |
    1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
         |                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         |
         = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#map_or_identity
         = note: `-W clippy::map-or-identity` implied by `-W clippy::all`
         = help: to override `-W clippy::all` add `#[allow(clippy::map_or_identity)]`
    help: consider using `unwrap_or`
         |
    1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
    1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
         |

The suggestion is valid, thus clean it up.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index d8d26870bea2..a20bd5006f38 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1323,7 +1323,7 @@ impl<T: Driver> Registration<T> {
         // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
         let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
 
-        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
+        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
     }
 
     /// Driver's `update_limit` callback.

base-commit: 420dd187e1572bb7e232781bc4377a80c8eb64fb
-- 
2.54.0

