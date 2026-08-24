Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB738E5ED;
	Mon, 24 Aug 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606425; cv=none; b=YUwWWUa97rx6PB4FV14kxYOpX0dHUJk/TfTxKAeXm/hFKCdtzLHgESRt5C9zzle4pd+ILkHsv7AE3Uh2NdmCxqnabl4NpobYmErrQo9JDD1QRsy1dncKNjSZ/RVz2g8pXVTwAEcHJJRorpPoOjv/yJ7LNihwTdrP5RzzmcaG+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606425; c=relaxed/simple;
	bh=gfrMoOzcGS7RwfJwX4rMg2yFC2DdX8Mz84jvvrwxjbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+hD/TszyBcFJa49qXWVOPYNWClqCKGiEeMlhcrX4G2iIhJAWobhMKydLmBHHwSbfCPiWl+9xT7MMtys6z+hiQNxh7ObG+0Qr2YxJikiMsacVo/9CnwDJnKUeQ89PsTcP4ozFj7Gzx59fLn6YJnAqMp57XtLLLSEkvS1QoyoKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acSm+yD9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acSm+yD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787606423; x=1819142423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gfrMoOzcGS7RwfJwX4rMg2yFC2DdX8Mz84jvvrwxjbc=;
  b=acSm+yD9nK9mpHs4nBFrwhxOHreFlDiRta/vT4YP3pBetddUdapo60J4
   s5m5jN9IP7ttPPAEy6ycP7CNXB5PtPCtQPgESdtZ46k7m6agP1QxD+7RQ
   LkO+Hh3nlcfSf1hp+M2SeJyZ02FcsnbY3rlK6ZS+RZzmqmRNa1K18u3Je
   P+Z2DXcFZlNWuc0QwvP5U/sgWoCBppau5V1DIn7IbRsXtJ6sxHwHpkh3K
   HpkncNtlFyCbh+pbajSwFZxeiwK8TbulaZURz1LLOC6lLlQdkezlAtK1M
   88UiOJqfLBlOpKdR+ahssvpne5XNeK9m60OV+R5CURc43thcYP5zLA/9w
   Q==;
X-CSE-ConnectionGUID: 7cTGPoCyRwOJWFdcr+Qvkw==
X-CSE-MsgGUID: ure6VZfDS6m3pFIJ1FteGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99417070"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="99417070"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 14:20:23 -0700
X-CSE-ConnectionGUID: YRt7ULOGR+6D5dHzrvQQTA==
X-CSE-MsgGUID: ayJtM19NSYa5z1Lp3K3FdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="267156167"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Aug 2026 14:20:21 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyc5R-000000004Ch-1XD6;
	Mon, 24 Aug 2026 21:20:12 +0000
Date: Tue, 25 Aug 2026 05:19:27 +0800
From: kernel test robot <lkp@intel.com>
To: Hang Nan <2122295973@qq.com>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, marcel@holtmann.org,
	luiz.dentz@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, pav@iki.fi
Subject: Re: [PATCH v3] Bluetooth: ISO: fix use-after-free of listener socket
 in iso_conn_ready
Message-ID: <202608250515.cLzFz5iN-lkp@intel.com>
References: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_1E12CBD7417A4019FF058EFD19B1DB930006@qq.com>

Hi Hang,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on linus/master v7.2]
[cannot apply to bluetooth-next/master next-20260821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hang-Nan/Bluetooth-ISO-fix-use-after-free-of-listener-socket-in-iso_conn_ready/20260818-193343
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/tencent_1E12CBD7417A4019FF058EFD19B1DB930006%40qq.com
patch subject: [PATCH v3] Bluetooth: ISO: fix use-after-free of listener socket in iso_conn_ready
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260825/202608250515.cLzFz5iN-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260825/202608250515.cLzFz5iN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608250515.cLzFz5iN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   net/bluetooth/iso.c: In function 'iso_conn_ready':
>> net/bluetooth/iso.c:2266:28: warning: left-hand operand of comma expression has no effect [-Wunused-value]
    2266 |                     (parent, SOCK_ZAPPED)) {
         |                            ^
>> net/bluetooth/iso.c:2267:25: error: implicit declaration of function 'release_sock_flagsock' [-Werror=implicit-function-declaration]
    2267 |                         release_sock_flagsock(parent);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/release_sock_flagsock +2267 net/bluetooth/iso.c

  2156	
  2157	static void iso_conn_ready(struct iso_conn *conn)
  2158	{
  2159		struct sock *parent = NULL;
  2160		struct sock *sk;
  2161		struct hci_ev_le_big_sync_established *ev = NULL;
  2162		struct hci_ev_le_pa_sync_established *ev2 = NULL;
  2163		struct hci_ev_le_per_adv_report *ev3 = NULL;
  2164		struct hci_conn *hcon;
  2165		struct hci_dev *hdev;
  2166	
  2167		BT_DBG("conn %p", conn);
  2168	
  2169		iso_conn_lock(conn);
  2170		sk = iso_sock_hold(conn);
  2171		iso_conn_unlock(conn);
  2172	
  2173		if (sk) {
  2174			lock_sock(sk);
  2175	
  2176			/* conn->sk may have become NULL if racing with sk close, but
  2177			 * due to held hdev->lock, it can't become different sk.
  2178			 */
  2179			if (!conn->sk) {
  2180				release_sock(sk);
  2181				sock_put(sk);
  2182				return;
  2183			}
  2184	
  2185			/* Attempt to update source address in case of BIS Sender if
  2186			 * the advertisement is using a random address.
  2187			 */
  2188			if (conn->hcon->type == BIS_LINK &&
  2189			    conn->hcon->role == HCI_ROLE_MASTER &&
  2190			    !bacmp(&conn->hcon->dst, BDADDR_ANY)) {
  2191				struct hci_conn *bis = conn->hcon;
  2192				struct adv_info *adv;
  2193	
  2194				adv = hci_find_adv_instance(bis->hdev,
  2195							    bis->iso_qos.bcast.bis);
  2196				if (adv && bacmp(&adv->random_addr, BDADDR_ANY)) {
  2197					iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
  2198					bacpy(&iso_pi(sk)->src, &adv->random_addr);
  2199				}
  2200			}
  2201	
  2202			iso_sock_ready(sk);
  2203	
  2204			release_sock(sk);
  2205			sock_put(sk);
  2206		} else {
  2207			hcon = conn->hcon;
  2208			if (!hcon)
  2209				return;
  2210	
  2211			hdev = hcon->hdev;
  2212	
  2213			if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
  2214				/* A BIS slave hcon is notified to the ISO layer
  2215				 * after the Command Complete for the LE Setup
  2216				 * ISO Data Path command is received. Get the
  2217				 * parent socket that matches the hcon BIG handle.
  2218				 */
  2219				parent = iso_get_sock(hdev, &hcon->src, &hcon->dst,
  2220						      BT_LISTEN, iso_match_big_hcon,
  2221						      hcon);
  2222			} else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
  2223				ev = hci_recv_event_data(hcon->hdev,
  2224							 HCI_EVT_LE_BIG_SYNC_ESTABLISHED);
  2225	
  2226				/* Get reference to PA sync parent socket, if it exists */
  2227				parent = iso_get_sock(hdev, &hcon->src, &hcon->dst,
  2228						      BT_LISTEN,
  2229						      iso_match_pa_sync_flag,
  2230						      NULL);
  2231				if (!parent && ev)
  2232					parent = iso_get_sock(hdev, &hcon->src,
  2233							      &hcon->dst,
  2234							      BT_LISTEN,
  2235							      iso_match_big, ev);
  2236			} else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
  2237				ev2 = hci_recv_event_data(hcon->hdev,
  2238							  HCI_EV_LE_PA_SYNC_ESTABLISHED);
  2239				if (ev2)
  2240					parent = iso_get_sock(hdev, &hcon->src,
  2241							      &hcon->dst,
  2242							      BT_LISTEN,
  2243							      iso_match_sid, ev2);
  2244			} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
  2245				ev3 = hci_recv_event_data(hcon->hdev,
  2246							  HCI_EV_LE_PER_ADV_REPORT);
  2247				if (ev3)
  2248					parent = iso_get_sock(hdev, &hcon->src,
  2249							      &hcon->dst,
  2250							      BT_LISTEN,
  2251							      iso_match_sync_handle_pa_report,
  2252							      ev3);
  2253			}
  2254	
  2255			if (!parent)
  2256				parent = iso_get_sock(hdev, &hcon->src, BDADDR_ANY,
  2257						      BT_LISTEN, iso_match_dst, BDADDR_ANY);
  2258	
  2259			if (!parent)
  2260				return;
  2261	
  2262			lock_sock(parent);
  2263	
  2264			/* The listener may have been closed concurrently. */
  2265			if (parent->sk_state != BT_LISTEN ||
> 2266			    (parent, SOCK_ZAPPED)) {
> 2267				release_sock_flagsock(parent);
  2268				sock_put(parent);
  2269				return;
  2270			}
  2271	
  2272			sk = iso_sock_alloc(sock_net(parent), NULL,
  2273					    BTPROTO_ISO, GFP_ATOMIC, 0);
  2274			if (!sk) {
  2275				release_sock(parent);
  2276				return;
  2277			}
  2278	
  2279			iso_sock_init(sk, parent);
  2280	
  2281			bacpy(&iso_pi(sk)->src, &hcon->src);
  2282	
  2283			/* Convert from HCI to three-value type */
  2284			if (hcon->src_type == ADDR_LE_DEV_PUBLIC)
  2285				iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
  2286			else
  2287				iso_pi(sk)->src_type = BDADDR_LE_RANDOM;
  2288	
  2289			/* If hcon has no destination address (BDADDR_ANY) it means it
  2290			 * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED or
  2291			 * HCI_EV_LE_PA_SYNC_ESTABLISHED so we need to initialize using
  2292			 * the parent socket destination address.
  2293			 */
  2294			if (!bacmp(&hcon->dst, BDADDR_ANY)) {
  2295				bacpy(&hcon->dst, &iso_pi(parent)->dst);
  2296				hcon->dst_type = le_addr_type(iso_pi(parent)->dst_type);
  2297			}
  2298	
  2299			if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
  2300				iso_pi(sk)->qos = iso_pi(parent)->qos;
  2301				hcon->iso_qos = iso_pi(sk)->qos;
  2302				iso_pi(sk)->bc_sid = iso_pi(parent)->bc_sid;
  2303				iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
  2304				memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis,
  2305				       ISO_MAX_NUM_BIS);
  2306				set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
  2307			}
  2308	
  2309			bacpy(&iso_pi(sk)->dst, &hcon->dst);
  2310	
  2311			/* Convert from HCI to three-value type */
  2312			if (hcon->dst_type == ADDR_LE_DEV_PUBLIC)
  2313				iso_pi(sk)->dst_type = BDADDR_LE_PUBLIC;
  2314			else
  2315				iso_pi(sk)->dst_type = BDADDR_LE_RANDOM;
  2316	
  2317			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
  2318			memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
  2319			iso_pi(sk)->base_len = iso_pi(parent)->base_len;
  2320	
  2321			hci_conn_hold(hcon);
  2322			iso_chan_add(conn, sk, parent);
  2323	
  2324			if ((ev && ((struct hci_evt_le_big_sync_established *)ev)->status) ||
  2325			    (ev2 && ev2->status)) {
  2326				/* Trigger error signal on child socket */
  2327				sk->sk_err = ECONNREFUSED;
  2328				sk->sk_error_report(sk);
  2329			}
  2330	
  2331			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
  2332				sk->sk_state = BT_CONNECT2;
  2333			else
  2334				sk->sk_state = BT_CONNECTED;
  2335	
  2336			/* Wake up parent */
  2337			parent->sk_data_ready(parent);
  2338	
  2339			release_sock(parent);
  2340			sock_put(parent);
  2341		}
  2342	}
  2343	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
