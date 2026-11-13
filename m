Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552971;
	b=CWplws+X+yBk6IbnFNYyLsOUC9y5B/DCZq5LrIF3TG3dSCwiKIVIKop+p7IWOHHi3Cvg
	 7BRUgA3UbACugi5MQrtOnlH/DKZEuEo4hBVjfRlWVQIITEEsxdFEtUW0e1nt0kqwwkksk
	 mIjLGV7RqRCUzN6/m+h7vPZbWSMlS3wyQtWLfTyQPTxaX2CPVPLuKLAhVwBl3tL/iMo4Y
	 atg1bKv3T5/620+otB90PRkqJ4VEzRhYQ3CppocWld0iACoppV6gjOlbTET59oVDccBJf
	 hbJc6SCgo+97wrOLb/IiquL32r3OSY+xmH+AutBzYM0j+1WH7vbJYMo6T3RpxhJfCtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552971;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=Pyq+1orvp/DnEDgd8Z2hspx3OAoSnJmA6J15epMOGkA=;
	b=A5zSo7+BnR1/II97M6WIo21auRDWnRFAgVo0USui+YYmn9sTs1/oVxIi3Od2mYLC/Hlw
	 5RBbVJsiWiizUbi3HMvgjZaqKcfe5eQ6hnS/Ztu0jS2d2KSxsatYrpM9Z9dauqLeiFmnZ
	 rhiIavQW8APNdF4DOD/w6N4z2/P2JoBx8LHqWyFRhlwTl6ywYY2tXejQJE6hms4DCVb42
	 4ziharGfJXf++qPAVt0IdjBrL4ODp5KFXlrShWkxGvED/vkNKTH39QVe96OKzwKIK0OrZ
	 L798ABfkP1kqhptR8/lFPVg6YPjZok21scwhYLzw1NJ5QXi4z5tjufhed0oDZA9EH5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzAf10c0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAD606A321;
	Fri, 13 Nov 2026 06:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzAf10c0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C81F000C5;
	Fri, 13 Nov 2026 06:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552971;
	bh=Pyq+1orvp/DnEDgd8Z2hspx3OAoSnJmA6J15epMOGkA=;
	h=From:To:Cc:Subject:Date;
	b=FzAf10c07bp3b7OqNi4NavlNXx5rCLbBIFtov7/EZekJWs5AtdBD4J/JJs5TeJVNs
	 U23ND7p88ZY5+D807NwjLhs4+dLxsOIZZWlTgt9YY1KxjYXL29n14rBy1+TTYZirhJ
	 jLBPEZWSKPloUizBco9jXzd7Exa7j5frNbAcEnhg2jsIdz64OzdZ093KHdSlgiG1iN
	 JARSVSAODHf10bpwzLO9FDpEmJieL6K5dU2viBloIIf0UDpyupR2a7rm2D6U0UBuln
	 HQPK0/Kq058vNQvqN9ELGpLrPTuw8OakYj6pFqu7vyWHhTsUejatisISZdzSqn2oTT
	 H/tWd80onSdIg==
From: Kees Cook <kees@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dennis Gilmore <dennis@ausil.us>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mld: Start the netdetect match counts at zero
Date: Thu, 12 Nov 2026 22:56:09 -0800
Message-ID: <20261113065608.i.785-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3056; i=kees@kernel.org; h=from:subject:message-id; bh=3cF43qk02UNaKgufk26U47Z2VrGNzATQVV0xUuQxQyQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnftnQ2X/QJW7njcdCtr32/q+Xus172nnXpZmvgT83az 7PXXRSP7ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiI3XyGfzr3l+a8ulKb1ay8 RuJpv9ByyyVmf8vyjwY8PnbgddQcjo+MDBcu8nr3q06Q/uPju2F7Zv/MSp7j1j7s87a83bbz2Bv maG4A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

iwl_mld_process_netdetect_res() allocates the netdetect results with
kzalloc_flex(), and iwl_mld_set_netdetect_info() allocates each match the
same way. kzalloc_flex() sets the __counted_by() counters "n_matches" and
"n_channels" to the allocated sizes when the compiler supports
__builtin_counted_by_ref(), but iwl_mld_set_netdetect_info() uses them as
the number of entries filled so far, expecting them to start at zero as
they did when the results came from kzalloc(). Starting from the
allocated sizes, every match and channel is stored past the end of its
array.

Reset both counters after allocation, since they are "usage" counters, not
"total allocation" counters. Also increment each counter before storing
the entry it counts, so that no store is beyond the __counted_by()
bound at the time it is made.

Build tested ARCH=x86_64 defconfig with CONFIG_IWLMLD=m and W=1, with
GCC 16.2.0.

Reported-by: Dennis Gilmore <dennis@ausil.us>
Closes: https://lore.kernel.org/all/20261112025252.71375-1-dennis@ausil.us/
Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/d3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/d3.c b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
index ce959363f62c..711877ac4c23 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/d3.c
@@ -1437,9 +1437,11 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 		match = kzalloc_flex(*match, channels, n_channels);
 		if (!match)
 			return;
+		/* The channels are counted below as they are added. */
+		match->n_channels = 0;
 
-		netdetect_info->matches[netdetect_info->n_matches] = match;
 		netdetect_info->n_matches++;
+		netdetect_info->matches[netdetect_info->n_matches - 1] = match;
 
 		/* We inverted the order of the SSIDs in the scan
 		 * request, so invert the index here.
@@ -1457,9 +1459,9 @@ iwl_mld_set_netdetect_info(struct iwl_mld *mld,
 		for_each_set_bit(j,
 				 (unsigned long *)&matches[i].matching_channels[0],
 				 sizeof(matches[i].matching_channels)) {
-			match->channels[match->n_channels] =
-				netdetect_cfg->channels[j]->center_freq;
 			match->n_channels++;
+			match->channels[match->n_channels - 1] =
+				netdetect_cfg->channels[j]->center_freq;
 		}
 	}
 }
@@ -1512,10 +1514,13 @@ iwl_mld_process_netdetect_res(struct iwl_mld *mld,
 	}
 	n_matches = hweight_long(matched_profiles);
 	netdetect_info = kzalloc_flex(*netdetect_info, matches, n_matches);
-	if (netdetect_info)
+	if (netdetect_info) {
+		/* iwl_mld_set_netdetect_info() counts the matches it adds. */
+		netdetect_info->n_matches = 0;
 		iwl_mld_set_netdetect_info(mld, netdetect_cfg, netdetect_info,
 					   resume_data->netdetect_res,
 					   matched_profiles);
+	}
 
 	wakeup.net_detect = netdetect_info;
  out:
-- 
2.55.0

